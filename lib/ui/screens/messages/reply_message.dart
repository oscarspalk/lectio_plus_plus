import 'package:flutter/material.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';

class ReplyMessageScreen extends StatelessWidget {
  const ReplyMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LppAppbar(title: "Svar besked", oldContext: context),
    );
  }
}
