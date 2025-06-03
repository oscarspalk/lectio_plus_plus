import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
part 'auth_state.gen.dart';

enum AuthStates { loading, unauthorized, authorized }

@DataClass()
abstract class AuthState {
  /// Default constructor
  factory AuthState({
    required AuthStates state,
    Student? student,
  }) = _$AuthStateImpl;
  AuthState.ctor();

  AuthStates get state;
  Student? get student;
}
