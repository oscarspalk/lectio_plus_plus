import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:lectio_wrapper/utils/dating.dart';
import 'package:lpp/topics/calendar/screens/create.dart';
import 'package:lpp/topics/calendar/widgets/information_dialog.dart';
import 'package:lpp/topics/calendar/widgets/week_header.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/appbar.dart';

import '../bloc/schema_bloc.dart';
import '../../../utils/helpers.dart';
import '../widgets/day_view.dart';

class SchemaScreen extends StatefulWidget {
  const SchemaScreen({super.key, this.bloc, this.name, this.room = false});

  final SchemaBloc? bloc;
  final String? name;
  final bool room;

  @override
  State<SchemaScreen> createState() => _SchemaScreenState();
}

const int startIndex = 700;

class _SchemaScreenState extends State<SchemaScreen> {
  final GlobalKey<ExpandableFabState> _fabKey = GlobalKey();
  late DateTime start =
      (widget.bloc ?? context.read<SchemaBloc>()).state.selectedTime;
  late PageController _pageController;
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
        firstDate: start.subtract(const Duration(days: 365)),
        lastDate: start.add(const Duration(days: 365)));
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
    var today = DateTime.now();
    var colorScheme = Theme.of(context).colorScheme;
    return BlocConsumer<SchemaBloc, SchemaState?>(
      listener: (context, state) {
        if (state != null && state.mode == SwitchMode.selector) {
          jumpDate(state.selectedTime);
        }
      },
      bloc: widget.bloc,
      builder: (context, state) {
        int? weekNum =
            state != null ? weekFromDateTime(state.selectedTime) : null;
        var matchingWeek = state!.weeks[state.selectedTime.year]
            ?.indexWhere((week) => week.weekNum == weekNum);
        var matchingDay = matchingWeek != null && matchingWeek != -1
            ? state.weeks[state.selectedTime.year]
                ?.elementAt(matchingWeek)
                .days
                .where((day) => day.date.day == state.selectedTime.day)
                .firstOrNull
            : null;
        return Scaffold(
          appBar: LppAppbar(
            title: "",
            actions: [
              if (matchingDay != null && matchingDay.informations.isNotEmpty)
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return InformationsDialog(
                            informations: matchingDay.informations,
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.bookmark_outline))
            ],
            titleWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Uge ${weekFromDateTime(state.selectedTime.copyWith(hour: 0, minute: 0))}",
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          " - ${months[state.selectedTime.month - 1]} ${state.selectedTime.year.toString()}",
                          style: const TextStyle(fontWeight: FontWeight.normal),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                if (widget.name != null)
                  Text(
                    "${widget.room ? "Lokale " : ""}${widget.name} skema",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  )
              ],
            ),
            bottom: WeekHeader(
              bloc: widget.bloc,
            ),
          ),
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: ExpandableFab(
              key: _fabKey,
              distance: 90.0,
              openButtonBuilder: DefaultFloatingActionButtonBuilder(
                  foregroundColor: colorScheme.onPrimary,
                  backgroundColor: colorScheme.primary,
                  child: const Icon(EvaIcons.moreVertical)),
              closeButtonBuilder: DefaultFloatingActionButtonBuilder(
                  foregroundColor: colorScheme.onPrimary,
                  backgroundColor: colorScheme.primary,
                  child: const Icon(EvaIcons.close)),
              children: [
                FloatingActionButton(
                  onPressed: state.selectedTime.day == today.day &&
                          state.selectedTime.month == today.month &&
                          state.selectedTime.year == today.year
                      ? null
                      : () {
                          (widget.bloc ?? context.read<SchemaBloc>())
                              .add(SwitchedDate(today));
                          _fabKey.currentState?.toggle();
                        },
                  foregroundColor: colorScheme.onPrimary,
                  backgroundColor: colorScheme.primary,
                  child: const Icon(Icons.today),
                ),
                FloatingActionButton(
                  heroTag: 3,
                  foregroundColor: colorScheme.onPrimary,
                  backgroundColor: colorScheme.primary,
                  child: const Icon(Icons.date_range),
                  onPressed: () async {
                    await showPicker();
                    _fabKey.currentState?.toggle();
                  },
                ),
                if (widget.bloc == null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: FloatingActionButton(
                        foregroundColor: colorScheme.onPrimary,
                        backgroundColor: colorScheme.primary,
                        heroTag: 2,
                        onPressed: () {
                          _fabKey.currentState?.toggle();

                          adSheet(const CreateAppointmentScreen(), context);
                        },
                        child: const Icon(EvaIcons.plus)),
                  ),
              ]),
          body: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) {
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
