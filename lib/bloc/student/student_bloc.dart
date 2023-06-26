import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lectio_wrapper/lectio/basic_info.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/topics/gyms/controller.dart';
import 'package:lectio_wrapper/types/gym.dart';

enum StudentStates {
  unauthorized,
  loading,
  authorized,
  loginError,
  internetError
}

class StudentState {
  Student? student;
  BasicInfo? basicInfo;
  StudentStates state;
  List<Gym> gyms;

  StudentState copyWith(
      {Student? student,
      BasicInfo? basicInfo,
      StudentStates? state,
      List<Gym>? gyms}) {
    return StudentState(state ?? this.state,
        gyms: gyms ?? this.gyms,
        basicInfo: basicInfo ?? this.basicInfo,
        student: student ?? this.student);
  }

  StudentState(this.state, {this.student, this.basicInfo, required this.gyms});
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
  StudentBloc() : super(StudentState(StudentStates.loading, gyms: [])) {
    on<LaunchedApp>((event, emit) async {
      emit(state.copyWith(state: StudentStates.loading));
      try {
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
            return emit(state.copyWith(
                state: StudentStates.authorized,
                student: student,
                basicInfo: info));
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
            return emit(state.copyWith(
                state: StudentStates.authorized,
                student: student,
                basicInfo: info));
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
}

StudentBloc getStudentBloc(BuildContext context) {
  return context.read<StudentBloc>();
}
