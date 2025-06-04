import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/core/decoration/spacing.dart';
import 'package:lectio_plus_plus/home/schema/cubit/schema_cubit.dart';
import 'package:lectio_plus_plus/home/schema/widgets/day_button.dart';

class DaySelector extends StatelessWidget implements PreferredSizeWidget {
  const DaySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDate = context
        .select((SchemaCubit cubit) => cubit.state.selectedDate)
        .copyWith(hour: 12, minute: 0);
    final monday =
        selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final weekDays = List.generate(
      7,
      (index) => monday.add(Duration(days: index)),
    );
    return GridView(
      padding: const EdgeInsets.symmetric(
          horizontal: CustomSpacing.xs, vertical: CustomSpacing.xs),
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: CustomSpacing.xxs,
      ),
      children: weekDays.map((weekDay) {
        return DayButton(date: weekDay);
      }).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
