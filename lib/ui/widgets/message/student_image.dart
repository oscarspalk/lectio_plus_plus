import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/context/student.dart';
import 'package:lectio_wrapper/types/message/meta/meta.dart';
import 'package:lpp/logic/bloc/student/student_bloc.dart';
import 'package:lpp/logic/bloc/student/student_cubit.dart';
import 'package:lpp/ui/widgets/loading/student_bloc_builder.dart';

class StudentImage extends StatelessWidget {
  const StudentImage({super.key, required this.entry, this.small = false});
  final MetaDataEntry? entry;
  final bool small;
  @override
  Widget build(BuildContext context) {
    var size = small ? 30.0 : 40.0;
    return SizedBox(
      height: size,
      width: size,
      child: entry != null
          ? StudentBlocBuilder<StudentCubit<Uint8List>, Uint8List?>(
              bloc: StudentCubit(
                  getStudentBloc(context).state.student!,
                  (primaryStudent) async => primaryStudent.getImage(
                      (await primaryStudent.context.get(entry!.id)
                              as StudentContext)
                          .imageId))
                ..load(),
              builder: (context, state) {
                return CircleAvatar(
                  radius: 24.0,
                  foregroundImage: Image.memory(state!).image,
                );
              },
            )
          : const CircleAvatar(
              radius: 24.0,
            ),
    );
  }
}
