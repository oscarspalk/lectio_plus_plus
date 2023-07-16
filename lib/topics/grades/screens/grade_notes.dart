import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/grades/note.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';

import '../../../logic/bloc/student/student_cubit.dart';

class GradeNoteScreen extends StatelessWidget {
  const GradeNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentBlocBuilder<StudentCubit<List<GradeNote>>, List<GradeNote>?>(
      builder: (context, state) {
        return Accordion(
            contentBorderWidth: 0.0,
            contentBackgroundColor: Theme.of(context).colorScheme.background,
            maxOpenSections: 1,
            children: state!.map((note) {
              return AccordionSection(
                  contentBorderRadius: 0.0,
                  headerBorderRadius: 0.0,
                  contentBorderWidth: 0.0,
                  leftIcon: CircleAvatar(
                    child: Text(note.teacherInitials.toUpperCase()),
                  ),
                  header: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(note.note.trim(),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text("${note.team.displayName} - ${note.gradeType}")
                    ],
                  ),
                  content: ListTile(title: Text(note.note.trim())));
            }).toList());
      },
    );
  }
}
