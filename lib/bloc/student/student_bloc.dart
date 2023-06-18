import 'package:biometric_storage/biometric_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio/basic_info.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/topics/gyms/controller.dart';
import 'package:lectio_wrapper/types/gym.dart';
import 'package:lpp/bloc/doc_parser.dart';

enum StudentStates { unauthorized, loading, authorized, error }

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

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  Future<BiometricStorageFile> getStorage() async {
    return await BiometricStorage().getStorage("keys");
  }

  StudentBloc() : super(StudentState(StudentStates.loading, gyms: [])) {
    on<LaunchedApp>((event, emit) async {
      emit(state.copyWith(state: StudentStates.loading));
      try {
        emit(state.copyWith(gyms: await GymController().list()));
        final storage = await getStorage();
        var data = await storage.read() ?? "";
        final map = DocParser.fromString(data);
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
        emit(state.copyWith(state: StudentStates.error));
      }
    });

    on<StudentLoggedIn>((event, emit) async {
      emit(state..state = StudentStates.loading);
      var account = event.account;
      final storage = await getStorage();
      Map<String, String> data = {};
      data.putIfAbsent("username", () => account.username);
      data.putIfAbsent("password", () => account.password);
      data.putIfAbsent("gymId", () => account.gymId.toString());
      await storage.write(DocParser.fromMap(data));
      var student = await account.login();

      if (student != null) {
        var info = await student.getBasicInfo();
        emit(state.copyWith(
            state: StudentStates.authorized,
            student: student,
            basicInfo: info));
      } else {
        emit(state.copyWith(state: StudentStates.unauthorized));
      }
    });

    on<StudentLoggedOut>((event, emit) async {
      emit(state..state = StudentStates.loading);
      final storage = await getStorage();
      await storage.delete();
      emit(state.copyWith(state: StudentStates.unauthorized));
    });
  }
}

StudentBloc getStudentBloc(BuildContext context) {
  return context.read<StudentBloc>();
}
