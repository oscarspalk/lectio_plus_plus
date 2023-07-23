import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lectio_wrapper/lectio/basic_info.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/topics/gyms/controller.dart';
import 'package:lectio_wrapper/types/context/team.dart';
import 'package:lectio_wrapper/types/gym.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StudentStates {
  unauthorized,
  loading,
  authorized,
  loginError,
  internetError
}

enum LoadingStates { caching, normal }

class StudentState {
  Student? student;
  BasicInfo? basicInfo;
  StudentStates state;
  List<Gym> gyms;
  List<Team> teams;
  LoadingStates loadingState;

  StudentState copyWith(
      {Student? student,
      BasicInfo? basicInfo,
      StudentStates? state,
      List<Gym>? gyms,
      LoadingStates? loadingState,
      List<Team>? teams}) {
    return StudentState(state ?? this.state,
        gyms: gyms ?? this.gyms,
        basicInfo: basicInfo ?? this.basicInfo,
        student: student ?? this.student,
        loadingState: loadingState ?? this.loadingState,
        teams: teams ?? this.teams);
  }

  StudentState(this.state,
      {this.student,
      this.basicInfo,
      required this.gyms,
      required this.loadingState,
      required this.teams});
}

sealed class StudentEvent {}

final class StudentLoggedIn extends StudentEvent {
  final Account account;
  StudentLoggedIn(this.account);
}

final class StudentLoggedOut extends StudentEvent {}

final class LaunchedApp extends StudentEvent {}

final class ResetError extends StudentEvent {}

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc()
      : super(StudentState(StudentStates.loading,
            gyms: [], teams: [], loadingState: LoadingStates.normal)) {
    on<LaunchedApp>((event, emit) async {
      emit(state.copyWith(state: StudentStates.loading));
      //try {
      emit(state.copyWith(gyms: await GymController().list()));
      const storage = FlutterSecureStorage();
      var map = await storage.readAll();

      if (map.containsKey("username") &&
          map.containsKey("password") &&
          map.containsKey("gymId")) {
        var student = await Account(
                int.parse(map["gymId"]!), map["username"]!, map["password"]!)
            .login();
        var info = await student?.getBasicInfo();
        if (student != null) {
          emit(state.copyWith(
            student: student,
          ));
          await _checkCache(emit);
          return emit(
              state.copyWith(state: StudentStates.authorized, basicInfo: info));
        }
      }
      return emit(state.copyWith(state: StudentStates.unauthorized));
      /*} catch (e) {
        emit(state.copyWith(state: StudentStates.internetError));
      }*/
    });

    on<StudentLoggedIn>((event, emit) async {
      var newState = state.copyWith(state: StudentStates.loading);
      emit(newState);
      Future func() async {
        try {
          var account = event.account;
          var student = await account.login();
          if (student != null) {
            const storage = FlutterSecureStorage();
            Map<String, String> data = {};
            data.putIfAbsent("username", () => account.username);
            data.putIfAbsent("password", () => account.password);
            data.putIfAbsent("gymId", () => account.gymId.toString());
            await storage.write(key: "username", value: account.username);
            await storage.write(key: "password", value: account.password);
            await storage.write(key: "gymId", value: account.gymId.toString());
            var info = await student.getBasicInfo();
            emit(state.copyWith(
              student: student,
            ));
            await _checkCache(emit);
            return emit(state.copyWith(
                state: StudentStates.authorized, basicInfo: info));
          }
          return emit(state.copyWith(state: StudentStates.loginError));
        } catch (e) {
          emit(state.copyWith(state: StudentStates.internetError));
        }
      }

      await func();
    });

    on<StudentLoggedOut>((event, emit) async {
      emit(state.copyWith(state: StudentStates.loading));
      const storage = FlutterSecureStorage();

      await storage.deleteAll();
      emit(state.copyWith(state: StudentStates.unauthorized));
    });

    on<ResetError>(
      (event, emit) {
        emit(state.copyWith(state: StudentStates.unauthorized));
      },
    );
  }

  Future<void> _checkCache(Emitter<StudentState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    var lastCheck = prefs.getString("cache_check");
    List<Team> metaTeams = [];
    if (lastCheck == null ||
        DateTime.parse(lastCheck).difference(DateTime.now()).inDays > 7) {
      emit(state.copyWith(loadingState: LoadingStates.caching));
      var teams = await state.student!.teams.list();
      for (var team in teams) {
        var teamContext =
            (await state.student!.context.get("HE${team.id}")) as TeamContext;
        metaTeams.add(
            Team(team.name, team.id.replaceAll("HE", ""), teamContext.subject));
      }
      prefs.setString("cache_check", DateTime.now().toIso8601String());
      prefs.setStringList(
          "teams_cache", metaTeams.map((e) => teamToString(e)).toList());
    } else {
      var strings = prefs.getStringList("teams_cache");
      if (strings != null) {
        for (var string in strings) {
          metaTeams.add(stringToTeam(string));
        }
      }
    }

    emit(state.copyWith(loadingState: LoadingStates.normal, teams: metaTeams));
  }
}

String teamToString(Team team) {
  return "name=${team.name};id=${team.id}";
}

Team stringToTeam(String team) {
  var topics = team.split(";");
  String name = "";
  String id = "";
  for (var topic in topics) {
    var split = topic.split('=');
    switch (split[0]) {
      case 'name':
        name = split[1];
        break;
      case 'id':
        id = split[1];
        break;
    }
  }
  return Team(name, id, name);
}

StudentBloc getStudentBloc(BuildContext context) {
  return context.read<StudentBloc>();
}
