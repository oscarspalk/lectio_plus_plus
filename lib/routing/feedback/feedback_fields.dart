import 'package:flutter/material.dart';
import 'package:lpp/widgets/layout/padded_column.dart';

class FeedbackFields extends StatefulWidget {
  const FeedbackFields({super.key, required this.onSubmit});

  final void Function(String) onSubmit;

  @override
  State<FeedbackFields> createState() => _FeedbackFieldsState();
}

class _FeedbackFieldsState extends State<FeedbackFields> {
  late TextEditingController feedbackController;

  @override
  void initState() {
    super.initState();
    feedbackController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: PaddedColumn(
            padding: 24.0,
            children: [
              TextField(
                  controller: feedbackController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    label: const Text("Hvad kan forbedres/feedback"),
                  )),
              FilledButton(
                  onPressed: () {
                    widget.onSubmit(feedbackController.text);
                  },
                  child: const Text("Færdig"))
            ],
          )),
    );
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }
}
