import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/lectio/basic_info.dart';
import 'package:lectio_wrapper/utils/dio_image_provider.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/logic/student/student_cubit.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/widgets/loading/student_bloc_builder.dart';
import 'dart:async';

class StudiekortScreen extends StatelessWidget {
  const StudiekortScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var colorscheme = Theme.of(context).colorScheme;
    return BlocBuilder<StudentBloc, StudentState>(
        builder: (context, studentState) {
      return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
              clipBehavior: Clip.hardEdge,
              color: colorscheme.secondary,
              child: SizedBox(
                height: 140.0,
                child: StudentBlocBuilder<StudentCubit<BasicInfo>, BasicInfo?>(
                    small: true,
                    builder: (context, state) {
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: StudentBlocBuilder<StudentCubit<DioImage>,
                                      DioImage?>(
                                  small: true,
                                  bloc: StudentCubit(
                                      getStudentBloc(context).state.student!,
                                      (student) async => student.getImage(
                                          state!.pictureId,
                                          fullsize: true))
                                    ..load(),
                                  builder: (context, state) {
                                    if (state == null) {
                                      return Container(
                                        height: 140.0,
                                      );
                                    }
                                    return Image(
                                      image: state,
                                      height: 140,
                                    );
                                  })),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state?.name ?? "",
                                            style: headerStyle.copyWith(
                                                color: colorscheme.onSecondary),
                                          ),
                                          Text(
                                            studentState.gymName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium!
                                                .copyWith(
                                                    color: colorscheme
                                                        .onSecondary),
                                          ),
                                        ]),
                                    const TimerWidget()
                                  ]),
                            ),
                          ),
                        ],
                      );
                    }),
              )));
    });
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerState();
}

class _TimerState extends State<TimerWidget> {
  late DateTime time;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    updateTime();
    timer = Timer.periodic(const Duration(seconds: 1), (t) => updateTime());
  }

  void updateTime() {
    setState(() {
      time = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text(
        "${DateFormat("HH:mm:ss").format(time)} - Lectio++",
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSecondary),
      ),
    ]);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
