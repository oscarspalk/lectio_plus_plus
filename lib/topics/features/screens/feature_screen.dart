import 'package:flutter/material.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MorphingSliverAppBar(
            title: Text(
              "Idéer",
              style: headerStyle,
            ),
            centerTitle: false,
          ),
        ],
      ),
    );
  }
}
