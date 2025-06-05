import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_plus_plus/core/decoration/theme_extension.dart';
import 'package:lectio_plus_plus/core/decoration/typography.dart';
import 'package:lectio_plus_plus/core/essentials/date_comparison.dart';
import 'package:lectio_plus_plus/home/schema/cubit/schema_cubit.dart';

final _dateNum = DateFormat('dd');
final _dayName = DateFormat.E();

class DayButton extends StatelessWidget {
  const DayButton({required this.date, required this.hasContent, super.key});

  final DateTime date;
  final bool hasContent;

  Color backgroundColor(
      {required bool isSelected, required ColorScheme scheme}) {
    if (isSelected) {
      return scheme.primaryContainer;
    }
    if (hasContent) {
      return scheme.secondaryContainer;
    }
    return scheme.surfaceContainer;
  }

  Color foregroundColor(
      {required bool isSelected, required ColorScheme scheme}) {
    if (isSelected) {
      return scheme.onPrimaryContainer;
    }
    if (hasContent) {
      return scheme.onSecondaryContainer;
    }
    return scheme.onSurface;
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate =
        context.select((SchemaCubit cubit) => cubit.state.selectedDate);
    final isSelected = selectedDate.isSameDay(date);
    final colorScheme = context.theme.colorScheme;
    return FilterChip(
      side: isSelected
          ? const BorderSide(width: 0, color: Colors.transparent)
          : null,
      padding: EdgeInsets.zero,
      backgroundColor:
          backgroundColor(isSelected: isSelected, scheme: colorScheme),
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
