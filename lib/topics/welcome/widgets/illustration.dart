import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

const colorKey = "#00FF00";

class Illustration extends StatelessWidget {
  const Illustration({super.key, required this.illustration});
  final String illustration;

  @override
  Widget build(BuildContext context) {
    return IllustrationHelper(
      primary: Theme.of(context).colorScheme.primary,
      svgName: illustration,
    );
  }
}

class IllustrationHelper extends StatefulWidget {
  const IllustrationHelper(
      {super.key, required this.primary, required this.svgName});

  final Color primary;
  final String svgName;
  @override
  State<IllustrationHelper> createState() => _IllustrationState();
}

class _IllustrationState extends State<IllustrationHelper> {
  String svgCode = "";

  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  void _loadSvg() async {
    String svgContent = await rootBundle
        .loadString("assets/illustrations/${widget.svgName}.svg");
    String newColor =
        "rgb(${widget.primary.red},${widget.primary.green},${widget.primary.blue})";
    setState(() {
      svgCode = svgContent
          .replaceAll(colorKey, newColor)
          .replaceAll(colorKey.toLowerCase(), newColor);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (svgCode.isEmpty) {
      return const SizedBox();
    }
    return SizedBox(width: 250, height: 200, child: SvgPicture.string(svgCode));
  }
}
