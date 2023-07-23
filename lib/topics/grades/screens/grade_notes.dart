import 'package:accordion/accordion.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/grades/note.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';
import 'package:lpp/widgets/primitive/team_name.dart';

import '../../../logic/student/student_cubit.dart';

class GradeNoteScreen extends StatelessWidget {
  const GradeNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentBlocBuilder<StudentCubit<List<GradeNote>>, List<GradeNote>?>(
      builder: (context, state) {
        var scheme = Theme.of(context).colorScheme;
        return Accordion(
            rightIcon:
                Icon(EvaIcons.arrowDownOutline, color: scheme.onBackground),
            contentBorderWidth: 0.0,
            headerBackgroundColor: scheme.background,
            contentBackgroundColor: scheme.background,
            maxOpenSections: 1,
            children: state!.map((note) {
              var textStyle = TextStyle(color: scheme.onBackground);
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
                      Text(
                        note.note.trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle,
                      ),
                      Row(
                        children: [
                          TeamName(teamName: note.team.name),
                          Text(" - ${note.gradeType}", style: textStyle),
                        ],
                      )
                    ],
                  ),
                  content: ListTile(title: Text(note.note.trim())));
            }).toList());
      },
    );
  }
}
