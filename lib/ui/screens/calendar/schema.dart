import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/bloc/schema/schema_bloc.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/calendar/day_view.dart';
import 'package:lpp/ui/screens/calendar/create.dart';
import 'package:lpp/ui/utils/helpers.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class SchemaScreen extends StatefulWidget {
  const SchemaScreen({super.key});
  @override
  State<SchemaScreen> createState() => _SchemaScreenState();
}

class _SchemaScreenState extends State<SchemaScreen> {
  late DateTime start = context.read<SchemaBloc>().state.selectedTime;
  late PageController _pageController;
  final int startIndex = 200;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: startIndex);
  }

  Future<void> showPicker() async {
    DateTime? maybeDate = await showDatePicker(
        context: context,
        initialDate: context.read<SchemaBloc>().state.selectedTime,
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
      builder: (context, state) {
        return Scaffold(
            appBar: LppAppbar(
              title: "",
              titleWidget:
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  months[state!.selectedTime.month - 1],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  " - Uge ${weekFromDateTime(state.selectedTime)}",
                ),
              ]),
              oldContext: context,
            ),
            floatingActionButton:
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              FloatingActionButton(
                tooltip: "Vælg dato",
                onPressed: showPicker,
                child: const Icon(EvaIcons.calendar),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: FloatingActionButton(
                    heroTag: 2,
                    onPressed: () {
                      Navigator.of(context).push(SwipeablePageRoute(
                        builder: (context) {
                          return const CreateAppointmentScreen();
                        },
                      ));
                    },
                    child: const Icon(EvaIcons.plus)),
              ),
            ]),
            body: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                onPageChanged: (value) {
                  context.read<SchemaBloc>().add(SwitchedDate(
                      start.add(Duration(days: value - startIndex))));
                },
                itemBuilder: (context, index) {
                  return DayView(
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
