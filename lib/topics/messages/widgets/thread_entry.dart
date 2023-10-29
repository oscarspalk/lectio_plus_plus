import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/topics/messages/widgets/message_files.dart';
import 'package:lpp/topics/messages/widgets/thread_context.dart';
import 'package:lpp/topics/modul/widgets/module_homework_display.dart';

import 'thread_list.dart';
import 'user_and_time_details.dart';

class ThreadEntryWidget extends StatefulWidget {
  const ThreadEntryWidget(
      {super.key, required this.entry, required this.message});
  final ThreadParent entry;
  final Message message;

  @override
  State<ThreadEntryWidget> createState() => _ThreadEntryWidgetState();
}

class _ThreadEntryWidgetState extends State<ThreadEntryWidget> {
  late String name;

  _buildState() {
    name = clipFirstnameAndClass(widget.entry.entry.user.name);
  }

  @override
  void initState() {
    super.initState();
    _buildState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: theme.colorScheme.onSurface)),
        color: theme.colorScheme.surface,
        child: DefaultTextStyle(
            style: TextStyle(color: theme.colorScheme.onSurface),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.entry.entry.topic,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: theme.colorScheme.onSurface),
                    ),
                    ThreadContext(
                        textColor: theme.colorScheme.onSurface,
                        color: theme.colorScheme.onSurface,
                        entry: widget.entry.entry,
                        message: widget.message)
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: LppHtml(content: widget.entry.entry.content)),
              MessageFileRow(files: widget.entry.entry.files),
              Divider(
                color: theme.colorScheme.onSurface,
              ),
              if (widget.entry.children.isNotEmpty)
                AnswersAndDividerMessage(
                  entries: widget.entry.children,
                  msg: widget.message,
                  indent: 0,
                ),
              UserAndTimeDetails(widget: widget, name: name, theme: theme),
            ])),
      ),
    ]);
  }
}

String clipFirstnameAndClass(String name) {
  String returnName = "";
  int firstSpace = name.indexOf(RegExp(r'\s'));
  if (firstSpace != -1) {
    returnName = name.substring(0, firstSpace);
    int firstParenthes = name.indexOf('(');
    int lastParenthes = name.indexOf(')', firstParenthes);
    if (firstParenthes != -1 && lastParenthes != -1) {
      returnName =
          "$returnName (${name.substring(firstParenthes + 1, lastParenthes)})";
    }
  }
  return returnName;
}

class AnswersAndDividerMessage extends StatefulWidget {
  const AnswersAndDividerMessage(
      {super.key,
      required this.entries,
      required this.msg,
      required this.indent});
  final List<ThreadEntry> entries;
  final Message msg;
  final int indent;

  @override
  State<AnswersAndDividerMessage> createState() =>
      _AnswersAndDividerMessageState();
}

class _AnswersAndDividerMessageState extends State<AnswersAndDividerMessage> {
  bool showing = false;

  @override
  void initState() {
    super.initState();
    showing = widget.indent == 1;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ExpansionTile(
        initiallyExpanded: widget.indent == 1,
        onExpansionChanged: (value) {
          setState(() {
            showing = value;
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Colors.transparent)),
        collapsedIconColor: theme.colorScheme.onSurface,
        iconColor: theme.colorScheme.onSurface,
        collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Colors.transparent)),
        title: Text(
          showing ? "Luk svar" : "Se svar",
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        children: [ThreadList(msg: widget.msg, indent: widget.indent)]);
  }
}
