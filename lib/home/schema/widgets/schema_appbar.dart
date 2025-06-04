import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_plus_plus/core/decoration/spacing.dart';
import 'package:lectio_plus_plus/core/decoration/typography.dart';
import 'package:lectio_plus_plus/home/schema/cubit/schema_cubit.dart';
import 'package:lectio_plus_plus/home/schema/widgets/day_selector.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';
import 'package:lectio_wrapper/utils/dating.dart';

class SchemaAppbar extends StatelessWidget implements PreferredSizeWidget {
  const SchemaAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final selectedDate =
        context.select((SchemaCubit cubit) => cubit.state.selectedDate);
    final week = weekFromDateTime(selectedDate);
    return AppBar(
      title: Column(
        children: [
          Text(
            l10n.schemaAppbarTitle(week),
            style: CustomTypography.headline(),
          ),
          const SmallSpacer(),
          Text(
            monthYear(selectedDate),
            style: CustomTypography.label(),
          ),
        ],
      ),
      bottom: const DaySelector(),
    );
  }

  String monthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 64);
}
