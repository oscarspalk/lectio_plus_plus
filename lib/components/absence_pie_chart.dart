import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/absence/entry.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class AbsencePieChart extends StatefulWidget {
  final List<AbsenceEntry> absence;
  final List<dynamic> colors;
  const AbsencePieChart(
      {super.key, required this.absence, required this.colors});

  @override
  State<AbsencePieChart> createState() => _AbsencePieChartState();
}

class _AbsencePieChartState extends State<AbsencePieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PieChart(PieChartData(
              sectionsSpace: 1,
              pieTouchData: PieTouchData(
                enabled: true,
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              sections: getSections())),
        ),
        touchedIndex == -1
            ? const Text("Tryk på en del af fraværsskiven")
            : Text(widget.absence[touchedIndex].team.name)
      ],
    );
  }

  List<PieChartSectionData> getSections() {
    return List.generate(widget.absence.length, (index) {
      return PieChartSectionData(
          radius: 60.0,
          color: HexColor.fromHex(widget.colors[index]),
          showTitle: false,
          value: widget.absence[index].regular.currentModules.current);
    });
  }
}
