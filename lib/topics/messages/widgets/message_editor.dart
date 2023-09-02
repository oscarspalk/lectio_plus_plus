import 'package:flutter/material.dart';
import 'package:rich_text_editor_controller/rich_text_editor_controller.dart';

class MessageEditor extends StatefulWidget {
  const MessageEditor({super.key, required this.value, required this.onChange});
  final String value;
  final Function(String value) onChange;

  @override
  State<MessageEditor> createState() => _MessageEditorState();
}

class _MessageEditorState extends State<MessageEditor> {
  late RichTextEditorController controller;

  @override
  void initState() {
    super.initState();
    controller = RichTextEditorController();

    controller.addListener(() {
      /*var plainText = controller.document.toDelta().map((delta) {
        if (delta.attributes == null) {
          return delta.value;
        }
        List<String> whatToAdd = [];
        bool bold = delta.attributes?["bold"] ?? false;
        bool italic = delta.attributes?["italic"] ?? false;
        bool underline = delta.attributes?["underline"] ?? false;
        String? link = delta.attributes?["link"];
        if (bold) {
          whatToAdd.add("b");
        }
        if (italic) {
          whatToAdd.add("i");
        }
        if (underline) {
          whatToAdd.add("u");
        }
        if (link != null && link.isNotEmpty) {
          whatToAdd.add("url=$link");
        }
        var output = "${delta.value}";

        for (var add in whatToAdd) {
          output = "[$add]$output[/${add.startsWith("url") ? "url" : add}]";
        }
        return output;
      }).join();
      widget.onChange(plainText);*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return RichTextField(controller: controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
