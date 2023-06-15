import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio/basic_info.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum StudentStates { unauthorized, loading, authorized }

class StudentState {
  Student? student;
  BasicInfo? basicInfo;
  StudentStates state;
  StudentState(this.state, {this.student, this.basicInfo});
}

sealed class StudentEvent {}

final class StudentLoggedIn extends StudentEvent {
  final Account account;
  StudentLoggedIn(this.account);
}

final class StudentLoggedOut extends StudentEvent {}

final class LaunchedApp extends StudentEvent {}

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentState(StudentStates.loading)) {
    on<LaunchedApp>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final String? username = prefs.getString("username");
      final String? password = prefs.getString("password");
      final int? gymId = prefs.getInt("gymId");
      if (username != null && password != null && gymId != null) {
        var student = await Account(gymId, username, password).login();
        var info = await student?.getBasicInfo();
        if (student != null) {
          return emit(StudentState(StudentStates.authorized,
              student: student, basicInfo: info));
        }
        return emit(state..state = StudentStates.unauthorized);
      }
    });

    on<StudentLoggedIn>((event, emit) async {
      emit(state..state = StudentStates.loading);
      var account = event.account;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("username", account.username);
      prefs.setString("password", account.password);
      prefs.setInt("gymId", account.gymId);

      var student = await account.login();

      if (student != null) {
        var info = await student.getBasicInfo();
        emit(StudentState(StudentStates.authorized,
            student: student, basicInfo: info));
      } else {
        emit(state..state = StudentStates.unauthorized);
      }
    });

    on<StudentLoggedOut>((event, emit) async {
      emit(state..state = StudentStates.loading);
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("username");
      prefs.remove("password");
      prefs.remove("gymId");
      emit(StudentState(StudentStates.unauthorized));
    });
  }
}

StudentBloc getStudentBloc(BuildContext context) {
  return context.read<StudentBloc>();
}
