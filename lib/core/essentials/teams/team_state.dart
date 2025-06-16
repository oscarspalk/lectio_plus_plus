import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:lectio_wrapper/types/primitives/team.dart';
part 'team_state.gen.dart';

@DataClass()
abstract class TeamState {
  /// Default constructor
  factory TeamState({
    required Map<String, Team> teams,
  }) = _$TeamStateImpl;

  TeamState.ctor();

  Map<String, Team> get teams;
}
