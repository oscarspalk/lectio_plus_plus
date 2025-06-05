import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_plus_plus/home/schema/cubit/schema_cubit.dart';
import 'package:lectio_plus_plus/home/schema/types/schema_state.dart';
import 'package:lectio_plus_plus/home/schema/widgets/day_selector.dart';
import 'package:lectio_wrapper/utils/dating.dart';

class DaySelectorManager extends StatefulWidget implements PreferredSizeWidget {
  const DaySelectorManager({super.key});

  @override
  State<DaySelectorManager> createState() => _DaySelectorManagerState();

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

const _initialPage = 100;

class _DaySelectorManagerState extends State<DaySelectorManager> {
  late PageController controller;
  final todayDay = DateTime.now().copyWith(hour: 12, minute: 0);

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: _initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SchemaCubit, SchemaState>(
      listener: (BuildContext context, SchemaState state) {
        if (controller.hasClients) {
          // lets calculate the current shown week.
          final startWeek = weekFromDateTime(todayDay);
          final currentPage = controller.page?.toInt() ?? 0;
          final offset = currentPage - _initialPage;
          final currentWeekDay = todayDay.add(Duration(days: 7 * offset));
          final currentWeek = weekFromDateTime(currentWeekDay);

          // now we check how far away from the selected week we are
          final selectedWeek = weekFromDateTime(state.selectedDate);

          if (selectedWeek != currentWeek) {
            final weekDifference = selectedWeek -
                startWeek +
                52 * (currentWeekDay.year - todayDay.year);

            controller.jumpToPage(_initialPage + weekDifference);
          }
        }
      },
      child: DaySelectorManagerWidget(
        todayDay: todayDay,
        controller: controller,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class DaySelectorManagerWidget extends StatelessWidget {
  const DaySelectorManagerWidget({
    required this.todayDay,
    required this.controller,
    super.key,
  });

  final DateTime todayDay;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const DaySelectorManager().preferredSize,
      child: PageView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          final weekOffset = Duration(days: 7 * (index - _initialPage));
          return DaySelector(
            thisWeekDay: todayDay.add(weekOffset),
          );
        },
      ),
    );
  }
}
