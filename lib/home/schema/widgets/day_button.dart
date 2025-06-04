import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_plus_plus/core/decoration/typography.dart';
import 'package:lectio_plus_plus/core/essentials/date_comparison.dart';
import 'package:lectio_plus_plus/home/schema/cubit/schema_cubit.dart';

final _dateNum = DateFormat('dd');
final _dayName = DateFormat.E();

class DayButton extends StatelessWidget {
  const DayButton({required this.date, super.key});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final selectedDate =
        context.select((SchemaCubit cubit) => cubit.state.selectedDate);
    final isSelected = selectedDate.isSameDay(date);
    return FilterChip(
      padding: EdgeInsets.zero,
      backgroundColor: isSelected ? Colors.blue : null,
      labelPadding: EdgeInsets.zero,
      label: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _dateNum.format(date),
              style: CustomTypography.h3(),
            ),
            Text(
              _dayName.format(date).toUpperCase(),
              style: CustomTypography.small(),
            )
          ],
        ),
      ),
      onSelected: (bool value) {
        context.read<SchemaCubit>().load(date);
      },
    );
  }
}
