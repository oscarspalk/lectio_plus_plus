import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
part 'schema_state.gen.dart';

@DataClass()
abstract class SchemaState {
  /// Default constructor
  factory SchemaState({
    required DateTime selectedDate,
    Day? currentDay,
  }) = _$SchemaStateImpl;
  SchemaState.ctor();

  DateTime get selectedDate;
  Day? get currentDay;
}
