import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/weeks/calendar_event.dart';
import 'package:lpp/topics/calendar/widgets/day_view.dart';
import 'package:lpp/utils/helpers.dart';

class DayHeader extends StatelessWidget {
  const DayHeader({
    super.key,
    required this.day,
  });

  final Day day;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: columnWidth,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          SizedBox(
            width: columnWidth,
            height: columnWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(weekDays[day.date.weekday - 1].substring(0, 3),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
                Container(
                  width: columnWidth - 30.0,
                  height: columnWidth - 30.0,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Center(
                    child: Text(
                      day.date.day.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Theme.of(context).colorScheme.surface),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            children: day.informations
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Container(
                        height: 30.0,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.trim(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface),
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ))
        ],
      ),
    );
  }
}
