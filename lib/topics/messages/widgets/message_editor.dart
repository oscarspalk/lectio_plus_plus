import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart';

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
    controller = quill.QuillController(
        document: quill.Document.fromDelta(Delta.fromOperations([])),
        selection: const TextSelection.collapsed(offset: 0));
    controller.addListener(() {
      var plainText = controller.document.toDelta().map((delta) {
        if (delta.attributes == null) {
          return delta.value;
        }
        List<String> whatToAdd = [];
        List<String> whatToAppend = [];
        bool bold = delta.attributes?["bold"] ?? false;
        bool italic = delta.attributes?["italic"] ?? false;
        bool underline = delta.attributes?["underline"] ?? false;
        String? link = delta.attributes?["link"];
        if (bold) {
          whatToAdd.add("[b]");
          whatToAppend.add("[/b]");
        }
        if (italic) {
          whatToAdd.add("[i]");
          whatToAppend.add("[/i]");
        }
        if (underline) {
          whatToAdd.add("[u]");
          whatToAppend.add("[/u]");
        }
        if (link != null && link.isNotEmpty) {
          whatToAdd.add("[url=$link]");
          whatToAppend.add("[/url]");
        }
        return "${whatToAdd.join()}${delta.value}${whatToAppend.join()}";
      }).join();

      widget.onChange(plainText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InputDecorator(
              decoration: const InputDecoration(label: Text("Indhold")),
              child: quill.QuillEditor.basic(
                  controller: controller, readOnly: false)),
          quill.QuillToolbar.basic(
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
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
