import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class MessageEditor extends StatefulWidget {
  const MessageEditor({super.key, required this.value, required this.onChange});
  final String value;
  final Function(String value) onChange;

  @override
  State<MessageEditor> createState() => _MessageEditorState();
}

class _MessageEditorState extends State<MessageEditor> {
  late quill.QuillController controller;

  @override
  void initState() {
    super.initState();
    controller = quill.QuillController.basic();
    controller.addListener(() {
      var plainText = controller.document.toDelta().map((delta) {
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
      widget.onChange(plainText);
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InputDecorator(
            decoration: const InputDecoration(label: Text("Indhold")),
            child: quill.QuillEditor.basic(
                controller: controller, readOnly: false)),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: quill.QuillToolbar.basic(
            iconTheme: quill.QuillIconTheme(
                iconSelectedFillColor: colorScheme.background,
                iconUnselectedFillColor: colorScheme.background,
                iconSelectedColor: colorScheme.primary,
                iconUnselectedColor: colorScheme.onBackground),
            controller: controller,
            showBackgroundColorButton: false,
            showAlignmentButtons: false,
            showBoldButton: true,
            showCenterAlignment: false,
            showCodeBlock: false,
            showClearFormat: false,
            showColorButton: false,
            showDirection: false,
            showDividers: false,
            showFontFamily: false,
            showFontSize: false,
            showHeaderStyle: false,
            showIndent: false,
            showInlineCode: false,
            showItalicButton: true,
            showJustifyAlignment: false,
            showLeftAlignment: false,
            showLink: true,
            showListBullets: false,
            showListCheck: false,
            showListNumbers: false,
            showQuote: false,
            showRedo: false,
            showRightAlignment: false,
            showSearchButton: false,
            showSmallButton: false,
            showStrikeThrough: false,
            showSubscript: false,
            showSuperscript: false,
            showUnderLineButton: true,
            showUndo: true,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
