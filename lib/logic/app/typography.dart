import 'package:flutter/material.dart';

class FontWeightsDemo extends StatelessWidget {
  final String font = "Fraunces";
  final double size = 20.0;
  final double height = 45.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: height,
            child: Center(
                child: Text(
              "This text has weight w100",
              style: TextStyle(
                fontVariations: <FontVariation>[FontVariation('wght', 100)],
                fontFamily: font,
                fontSize: size,
              ),
            )),
          ),
          Container(
            height: height,
            child: Center(
                child: Text(
              "This text has weight w200",
              style: TextStyle(
                fontFamily: font,
                fontSize: size,
                fontVariations: <FontVariation>[FontVariation('wght', 200)],
              ),
            )),
          ),
          Container(
            height: height,
            child: Center(
                child: Text(
              "This text has weight w300",
              style: TextStyle(
                fontFamily: font,
                fontSize: size,
                fontVariations: <FontVariation>[FontVariation('wght', 300)],
              ),
            )),
          ),
          Container(
            height: height,
            child: Center(
                child: Text(
              "This text has weight w400",
              style: TextStyle(
                fontFamily: font,
                fontSize: size,
                fontVariations: <FontVariation>[FontVariation('wght', 400)],
              ),
            )),
          ),
          Container(
            height: height,
            child: Center(
                child: Text(
              "This text has weight w500",
              style: TextStyle(
                fontFamily: font,
                fontSize: size,
                fontVariations: <FontVariation>[FontVariation('wght', 500)],
              ),
            )),
          ),
          Container(
            height: height,
            child: Center(
                child: Text(
              "This text has weight w600",
              style: TextStyle(
                fontFamily: font,
                fontSize: size,
                fontVariations: <FontVariation>[FontVariation('wght', 600)],
              ),
            )),
          ),
          Container(
            height: height,
            child: Center(
                child: Text(
              "This text has weight w700",
              style: TextStyle(
                fontFamily: font,
                fontSize: size,
                fontVariations: <FontVariation>[FontVariation('wght', 700)],
              ),
            )),
          ),
          Container(
            height: height,
            child: Center(
                child: Text(
              "This text has weight w800",
              style: TextStyle(
                fontFamily: font,
                fontSize: size,
                fontVariations: <FontVariation>[FontVariation('wght', 800)],
              ),
            )),
          ),
          Container(
            height: height,
            child: Center(
                child: Text(
              "This text has weight w900",
              style: TextStyle(
                fontFamily: font,
                fontSize: size,
                fontVariations: <FontVariation>[FontVariation('wght', 900)],
              ),
            )),
          ),
        ],
      ),
    );
  }
}

class LppTypography {
  static TextStyle? bodySmall(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Theme.of(context)
        .textTheme
        .bodySmall
        ?.copyWith(color: colorScheme.onSurface, fontSize: 12, height: 4 / 3);
  }

  static TextStyle? headlineSmall(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontFamily: 'Fraunces',
        color: colorScheme.onSurface,
        fontVariations: [
          const FontVariation("soft", 100.0),
          const FontVariation("wonk", 1.0),
          const FontVariation('wght', 600)
        ],
        fontSize: 24.0,
        height: 4 / 3);
  }

  static TextStyle? labelSmall(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Theme.of(context).textTheme.labelSmall?.copyWith(
        color: colorScheme.onSurface,
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        height: 4 / 3);
  }
}
