import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/utils/dating.dart';
import 'package:lpp/topics/calendar/screens/create.dart';
import 'package:lpp/topics/calendar/widgets/week_header.dart';
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

const int startIndex = 200;

class _SchemaScreenState extends State<SchemaScreen> {
  late DateTime start =
      (widget.bloc ?? context.read<SchemaBloc>()).state.selectedTime;
  late PageController _pageController;
  //int _index = startIndex;
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
      jumpDate(maybeDate);
    }
  }

  void jumpDate(DateTime date, {int? animMillis}) {
    DateTime fixedTime = date.copyWith(hour: 12);
    Duration timeDiff = start.difference(fixedTime);
    double dayDiff = timeDiff.inHours / 24;
    int pageIndex = startIndex - dayDiff.round();
    if (animMillis != null) {
      _pageController.animateToPage(pageIndex,
          duration: Duration(milliseconds: animMillis), curve: Curves.easeIn);
    } else {
      _pageController.jumpToPage(pageIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return BlocConsumer<SchemaBloc, SchemaState?>(
      listener: (context, state) {
        if (state != null && state.mode == SwitchMode.selector) {
          /*var currentDate = start.add(Duration(days: _index - startIndex));
          var diff = currentDate.difference(state.selectedTime).inDays.abs();*/
          jumpDate(state.selectedTime); //animMillis: (diff - 1) * 150 + 250);
        }
      },
      bloc: widget.bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: LppAppbar(
            title: "",
            titleWidget: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Uge ${weekFromDateTime(state!.selectedTime.copyWith(hour: 0, minute: 0))}",
                ),
                Text(
                  " - ${widget.name != null ? "${widget.name} " : ""}${months[state.selectedTime.month - 1]} ${state.selectedTime.year.toString()}",
                  style: const TextStyle(fontWeight: FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
            bottom: WeekHeader(
              bloc: widget.bloc,
            ),
          ),
          floatingActionButton:
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            FloatingActionButton(
              foregroundColor: colorScheme.onPrimary,
              backgroundColor: colorScheme.primary,
              tooltip: "Vælg dato",
              onPressed: showPicker,
              child: const Icon(EvaIcons.calendar),
            ),
            if (widget.bloc == null)
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: FloatingActionButton(
                    foregroundColor: colorScheme.onPrimary,
                    backgroundColor: colorScheme.primary,
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
                //_index = value;
                (widget.bloc ?? context.read<SchemaBloc>()).add(
                    SliderSwitchedDate(
                        start.add(Duration(days: value - startIndex))));
              },
              itemBuilder: (context, index) {
                return DayView(
                    bloc: widget.bloc,
                    daySelected: start.add(Duration(days: index - startIndex)));
              }),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
