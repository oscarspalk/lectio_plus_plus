import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/lectio/basic_info.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/topics/gyms/controller.dart';
import 'package:lectio_wrapper/types/gym.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';
import 'package:lpp/logic/cache/caching_service.dart';
import 'package:lpp/logic/cache/login_service.dart';

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
  String gymName;

  StudentState copyWith(
      {Student? student,
      BasicInfo? basicInfo,
      StudentStates? state,
      List<Gym>? gyms,
      LoadingStates? loadingState,
      List<Team>? teams,
      String? gymName}) {
    return StudentState(state ?? this.state,
        gyms: gyms ?? this.gyms,
        basicInfo: basicInfo ?? this.basicInfo,
        student: student ?? this.student,
        loadingState: loadingState ?? this.loadingState,
        teams: teams ?? this.teams,
        gymName: gymName ?? this.gymName);
  }

  StudentState(this.state,
      {this.student,
      this.basicInfo,
      required this.gyms,
      required this.loadingState,
      required this.teams,
      required this.gymName});
}

sealed class StudentEvent {}

final class StudentLoggedIn extends StudentEvent {
  final Account account;
  StudentLoggedIn(this.account);
}

final class StudentLoggedOut extends StudentEvent {}

final class LaunchedApp extends StudentEvent {}

final class ResetError extends StudentEvent {}

final class AutologinError extends StudentEvent {}

final class ListGyms extends StudentEvent {}

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final LoginService loginService = LoginService();
  StudentBloc()
      : super(StudentState(StudentStates.loading,
            gyms: [],
            teams: [],
            loadingState: LoadingStates.normal,
            gymName: "")) {
    on<ListGyms>(
      (event, emit) async {
        var startState = state.state;
        emit(state.copyWith(state: StudentStates.loading));
        var gyms = await GymController().list();
        emit(state.copyWith(gyms: gyms, state: startState));
      },
    );

    on<AutologinError>((event, emit) async {
      await loginService.loginFromSaved();
    });

    on<LaunchedApp>((event, emit) async {
      emit(state.copyWith(state: StudentStates.loading));
      try {
        var student = await loginService.loadSaved();
        if (student != null) {
          emit(state.copyWith(student: student));
          var cacheState =
              await CachingService(student, state.gyms).loadSaved();
          return emit(state.copyWith(
              state: StudentStates.authorized,
              teams: cacheState.teams,
              gymName: cacheState.gymName));
        }

        emit(state.copyWith(state: StudentStates.unauthorized));
        add(ListGyms());
      } catch (e) {
        add(AutologinError());
        //emit(state.copyWith(state: StudentStates.internetError));
      }
    });

    on<StudentLoggedIn>((event, emit) async {
      emit(state.copyWith(state: StudentStates.loading));
      try {
        var account = event.account;
        var student = await loginService.login(account);
        if (student != null) {
          emit(state.copyWith(
            student: student,
          ));
          var cacheState =
              await CachingService(student, state.gyms).loadSaved();
          return emit(state.copyWith(
              state: StudentStates.authorized,
              teams: cacheState.teams,
              gymName: cacheState.gymName));
        }
        return emit(state.copyWith(state: StudentStates.loginError));
      } catch (e) {
        emit(state.copyWith(state: StudentStates.internetError));
      }
    });

    on<StudentLoggedOut>((event, emit) async {
      emit(state.copyWith(state: StudentStates.loading));
      await loginService.delete();
      await CachingService(state.student!, state.gyms).deleteAll();
      emit(state.copyWith(state: StudentStates.unauthorized, student: null));
      add(ListGyms());
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
