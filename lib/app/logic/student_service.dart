import 'package:barrel_files_annotation/barrel_files_annotation.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';

@IncludeInBarrelFile()
class StudentService {
  StudentService({required this.student});

  final Student student;
}
