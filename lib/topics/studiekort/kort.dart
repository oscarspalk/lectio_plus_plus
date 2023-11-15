import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/studiekort/kort.dart';
import 'package:lectio_wrapper/utils/dio_image_provider.dart';
import 'package:lpp/logic/student/student_bloc.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/studiekort/studiekort_bloc.dart';
import 'package:lpp/utils/state_pattern.dart';
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                  clipBehavior: Clip.hardEdge,
                  color: colorscheme.secondary,
                  child: SizedBox(
                    height: 140.0,
                    child: BlocBuilder<StudiekortBloc,
                            StatePattern<(Kort?, DioImage?)?>>(
                        builder: (context, state) {
                      if (state.state == null || state.state!.$1 == null) {
                        return Container();
                      }
                      return Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: state.state?.$2 != null
                                  ? Image(
                                      image: state.state!.$1!.picture,
                                      height: 140,
                                    )
                                  : Container()),
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
                                            state.state!.$1!.name,
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
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton.icon(
                      onPressed: () {
                        var bloc = context.read<StudiekortBloc>();
                        bloc.qr();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                                title: null,
                                insetPadding: EdgeInsets.zero,
                                titlePadding: EdgeInsets.zero,
                                contentPadding: EdgeInsets.zero,
                                children: [
                                  SizedBox(
                                    width: 220,
                                    height: 220,
                                    child: BlocBuilder<StudiekortBloc,
                                        StatePattern<(Kort?, DioImage?)?>>(
                                      bloc: bloc,
                                      builder: (context, state) {
                                        if (state.state != null &&
                                            state.state!.$2 != null) {
                                          return Image(image: state.state!.$2!);
                                        }
                                        return const CircularProgressIndicator();
                                      },
                                    ),
                                  ),
                                ]);
                          },
                        );
                      },
                      icon: const Icon(Icons.qr_code),
                      label: const Text("Vis QR")),
                ],
              )
            ],
          ));
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
