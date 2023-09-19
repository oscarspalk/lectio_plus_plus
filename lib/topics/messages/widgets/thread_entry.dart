import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/topics/messages/widgets/message_files.dart';
import 'package:lpp/topics/messages/widgets/thread_context.dart';
import 'package:lpp/topics/modul/widgets/module_homework_display.dart';
import 'package:lpp/topics/people/widget/person_details.dart';
import 'package:lpp/utils/ad_route.dart';

class ThreadEntryWidget extends StatefulWidget {
  const ThreadEntryWidget(
      {super.key, required this.entry, required this.message});
  final ThreadEntry entry;
  final Message message;

  @override
  State<ThreadEntryWidget> createState() => _ThreadEntryWidgetState();
}

class _ThreadEntryWidgetState extends State<ThreadEntryWidget> {
  late String name;

  _buildState() {
    name = clipFirstnameAndClass(widget.entry.user.name);
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
          color: theme.colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0)
                .copyWith(bottom: 8.0),
            child: DefaultTextStyle(
                style: TextStyle(color: theme.colorScheme.onPrimary),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.entry.topic,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(color: theme.colorScheme.onPrimary),
                          ),
                          ThreadContext(
                              color: theme.colorScheme.onPrimary,
                              entry: widget.entry,
                              message: widget.message)
                        ],
                      ),
                      LppHtml(content: widget.entry.content),
                      MessageFileRow(files: widget.entry.files)
                    ])),
          )),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            adSheet(PersonDetails(entry: widget.entry.user), context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),
              Text(
                DateFormat("HH:mm dd/MM").format(widget.entry.at),
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
        ),
      )
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
