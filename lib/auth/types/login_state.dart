import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:lectio_wrapper/lectio/student.dart';
import 'package:lectio_wrapper/types/gym.dart';
part 'login_state.gen.dart';

@DataClass()
abstract class LoginState {
  /// Default constructor
  factory LoginState({
    required LoginStage stage,
    Gym? selectedGym,
    String? uniloginUrl,
    Student? student,
  }) = _$LoginStateImpl;

  LoginState.ctor();

  Gym? get selectedGym;
  LoginStage get stage;
  String? get uniloginUrl;
  Student? get student;
}

enum LoginStage { selectGym, unilogin, finishing }
