import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lectio_plus_plus/core/decoration/spacing.dart';
import 'package:lectio_plus_plus/core/decoration/typography.dart';
import 'package:lectio_plus_plus/core/essentials/center_loader.dart';
import 'package:lectio_plus_plus/home/schema/cubit/schema_cubit.dart';
import 'package:lectio_plus_plus/l10n/l10n.dart';
import 'package:lectio_wrapper/utils/dating.dart';

class SchemaPage extends StatelessWidget {
  const SchemaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SchemaView();
  }
}

class SchemaView extends StatelessWidget {
  const SchemaView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: SchemaAppbar(),
      body: DayView(),
    );
  }
}

class DayView extends StatelessWidget {
  const DayView({super.key});

  @override
  Widget build(BuildContext context) {
    final day = context.select((SchemaCubit cubit) => cubit.state.currentDay);
    if (day != null) {
      return Text("${day.events.length}");
    }
    return const CenterLoader();
  }
}

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
    );
  }

  String monthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
