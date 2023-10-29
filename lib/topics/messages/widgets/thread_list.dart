import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/message/message.dart';
import 'package:lpp/topics/messages/widgets/thread_entry.dart';

class ThreadList extends StatefulWidget {
  const ThreadList({
    super.key,
    required this.msg,
    required this.indent,
  });

  final Message msg;
  final int indent;
  @override
  State<ThreadList> createState() => _ThreadListState();
}

class ThreadParent {
  ThreadEntry entry;
  List<ThreadEntry> children;
  ThreadParent(this.entry, this.children);
}

class _ThreadListState extends State<ThreadList> {
  late List<ThreadParent> threads;
  _makeThreads() {
    threads = [];
    List<ThreadEntry> possible =
        widget.msg.thread.where((element) => 0 >= widget.indent).toList();
    if (possible.isNotEmpty) {
      ThreadParent? threadParent = ThreadParent(possible.first, []);
      for (var thread in possible.sublist(1)) {
        if (0 >= widget.indent) {
          if (0 == widget.indent && threadParent != null) {
            threads.add(threadParent);
            threadParent = ThreadParent(thread, []);
          } else if (threadParent != null && 0 > widget.indent) {
            threadParent.children.add(thread);
          }
        }
      }
      threads.add(threadParent!);
    }
  }

  @override
  void initState() {
    super.initState();
    _makeThreads();
  }

  @override
  void didUpdateWidget(covariant ThreadList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _makeThreads();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: widget.indent == 0 ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      itemCount: threads.length,
      itemBuilder: (context, index) {
        var threadItem = threads.elementAt(index);
        return ThreadEntryWidget(
          entry: threadItem,
          message: widget.msg,
        );
      },
    );
  }
}
