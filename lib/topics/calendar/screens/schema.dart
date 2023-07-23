import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/topics/calendar/screens/create.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/appbar.dart';

import '../bloc/schema_bloc.dart';
import '../../../utils/helpers.dart';
import '../widgets/day_view.dart';

class SchemaScreen extends StatefulWidget {
  const SchemaScreen({super.key, this.bloc, this.name});

  final SchemaBloc? bloc;
  final String? name;

  @override
  State<SchemaScreen> createState() => _SchemaScreenState();
}

class _SchemaScreenState extends State<SchemaScreen> {
  late DateTime start =
      (widget.bloc ?? context.read<SchemaBloc>()).state.selectedTime;
  late PageController _pageController;
  final int startIndex = 200;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: startIndex);
  }

  Future<void> showPicker() async {
    var bloc = widget.bloc ?? context.read<SchemaBloc>();
    DateTime? maybeDate = await showDatePicker(
        context: context,
        initialDate: bloc.state.selectedTime,
        firstDate: start.subtract(const Duration(days: 150)),
        lastDate: start.add(const Duration(days: 150)));
    if (maybeDate != null) {
      DateTime fixedTime = maybeDate.copyWith(hour: 12);
      Duration timeDiff = start.difference(fixedTime);
      double dayDiff = timeDiff.inHours / 24;
      _pageController.jumpToPage(
        startIndex - dayDiff.round(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SchemaBloc, SchemaState?>(
      bloc: widget.bloc,
      builder: (context, state) {
        return Scaffold(
            appBar: LppAppbar(
              title: "",
              titleWidget: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Uge ${weekFromDateTime(state!.selectedTime)}",
                  ),
                  Text(
                    "${widget.name != null ? "${widget.name} " : ""}${months[state.selectedTime.month - 1]} ${state.selectedTime.year.toString()}",
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
            floatingActionButton:
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              FloatingActionButton(
                tooltip: "Vælg dato",
                onPressed: showPicker,
                child: const Icon(EvaIcons.calendar),
              ),
              if (widget.bloc == null)
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: FloatingActionButton(
                      heroTag: 2,
                      onPressed: () {
                        adSheet(const CreateAppointmentScreen(), context);
                      },
                      child: const Icon(EvaIcons.plus)),
                ),
            ]),
            body: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  (widget.bloc ?? context.read<SchemaBloc>()).add(SwitchedDate(
                      start.add(Duration(days: value - startIndex))));
                },
                itemBuilder: (context, index) {
                  return DayView(
                      bloc: widget.bloc,
                      daySelected:
                          start.add(Duration(days: index - startIndex)));
                }));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
