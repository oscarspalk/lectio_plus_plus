import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/core/decoration/spacing.dart';
import 'package:lectio_plus_plus/home/schema/cubit/schema_cubit.dart';
import 'package:lectio_plus_plus/home/schema/widgets/day_button.dart';

class DaySelector extends StatelessWidget {
  const DaySelector({required this.thisWeekDay, super.key});

  final DateTime thisWeekDay;

  @override
  Widget build(BuildContext context) {
    final state = context.select((SchemaCubit cubit) => cubit.state);
    final hasContent = state.hasContent;
    final monday =
        thisWeekDay.subtract(Duration(days: thisWeekDay.weekday - 1));
    final weekDays = List.generate(
      7,
      (index) => monday.add(Duration(days: index)),
    );
    return GridView(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomSpacing.xs,
        vertical: CustomSpacing.xs,
      ),
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: CustomSpacing.xxs,
      ),
      children: weekDays.map((weekDay) {
        return DayButton(
          date: weekDay,
          hasContent: hasContent[weekDay.weekday - 1],
        );
      }).toList(),
    );
  }
}
