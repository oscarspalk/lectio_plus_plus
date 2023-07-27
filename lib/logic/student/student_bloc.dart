import 'dart:async';

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
      Future<Student?> login(Account account) async {
        var student = await account.login();
        if (student != null) {
          _saveCreds(student, account);
          return student;
        }
        return null;
      }

      emit(state.copyWith(state: StudentStates.loading));
      try {
        emit(state.copyWith(gyms: await GymController().list()));
        const storage = FlutterSecureStorage();
        var map = await storage.readAll();

        if (map.containsKey("username") &&
            map.containsKey("password") &&
            map.containsKey("gymId")) {
          var account = Account(
              int.parse(map["gymId"]!), map["username"]!, map["password"]!);
          var checkedStudent = await _checkCreds(account);
          var student = checkedStudent ?? await login(account);
          if (student != null) {
            emit(state.copyWith(
              student: student,
            ));
            await _checkCache(emit);
            return emit(state.copyWith(state: StudentStates.authorized));
          }
        }
        return emit(state.copyWith(state: StudentStates.unauthorized));
      } catch (e) {
        emit(state.copyWith(state: StudentStates.internetError));
      }
    });

    on<StudentLoggedIn>((event, emit) async {
      var newState = state.copyWith(state: StudentStates.loading);
      emit(newState);
      Future login() async {
        try {
          var account = event.account;
          var student = await account.login();
          if (student != null) {
            _saveCreds(student, account);
            emit(state.copyWith(
              student: student,
            ));
            await _checkCache(emit);
            return emit(state.copyWith(state: StudentStates.authorized));
          }
          return emit(state.copyWith(state: StudentStates.loginError));
        } catch (e) {
          emit(state.copyWith(state: StudentStates.internetError));
        }
      }

      await login();
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

  _saveCreds(Student student, Account account) async {
    var jar = await student.getCookies();
    const storage = FlutterSecureStorage();
    await storage.write(key: "username", value: account.username);
    await storage.write(key: "password", value: account.password);
    await storage.write(key: "gymId", value: account.gymId.toString());
    await storage.write(
        key: "cookie",
        value: jar.values.map((e) => "${e.name}=${e.value}").join(","));
    await storage.write(
        key: "last_login", value: DateTime.now().toIso8601String());
  }

  Future<Student?> _checkCreds(Account account) async {
    const storage = FlutterSecureStorage();
    var lastLoginStr = await storage.read(key: 'last_login');
    var cookie = await storage.read(key: 'cookie');
    if (lastLoginStr != null && cookie != null) {
      var lastLogin = DateTime.parse(lastLoginStr);
      if (lastLogin.difference(DateTime.now()).inDays.abs() > 20) {
        return null;
      }
      return account.loginWithCookies(cookie);
    }
    return null;
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
        metaTeams.add(Team(
            name: team.name,
            id: team.id.replaceAll("HE", ""),
            displayName: teamContext.subject));
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
  return "name=${team.name};id=${team.id};display=${team.displayName}";
}

Team stringToTeam(String team) {
  var topics = team.split(";");
  String name = "";
  String id = "";
  String display = "";
  for (var topic in topics) {
    var split = topic.split('=');
    switch (split[0]) {
      case 'name':
        name = split[1];
        break;
      case 'id':
        id = split[1];
        break;
      case 'display':
        display = split[1];
        break;
    }
  }
  return Team(name: name, id: id, displayName: display);
}

StudentBloc getStudentBloc(BuildContext context) {
  return context.read<StudentBloc>();
}
