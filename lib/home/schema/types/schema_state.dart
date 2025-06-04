import 'package:data_class_plugin/data_class_plugin.dart';
import 'package:lectio_plus_plus/home/schema/types/schema_data_source.dart';
part 'schema_state.gen.dart';

@DataClass()
abstract class SchemaState {
  /// Default constructor
  factory SchemaState({
    required List<bool> hasContent,
    required DateTime selectedDate,
    SchemaDataSource? schemaDataSource,
  }) = _$SchemaStateImpl;

  SchemaState.ctor();

  List<bool> get hasContent;
  DateTime get selectedDate;
  SchemaDataSource? get schemaDataSource;
}
