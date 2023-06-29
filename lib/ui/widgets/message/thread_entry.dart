import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lectio_wrapper/types/message/message.dart';

class ThreadEntryWidget extends StatelessWidget {
  const ThreadEntryWidget({super.key, required this.entry});
  final ThreadEntry entry;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.user.name.trim()),
                  Text(
                    DateFormat("HH:mm dd/MM").format(entry.at),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: RelativeRect.fill,
                        items: [
                          PopupMenuItem(
                              enabled: entry.files!.isNotEmpty,
                              child: const Text("Filer")),
                          const PopupMenuItem(child: Text("Rediger")),
                          const PopupMenuItem(child: Text("Slet"))
                        ]);
                  },
                  icon: const Icon(EvaIcons.moreVerticalOutline))
            ],
          ),
          Text(entry.content)
        ],
      ),
    ));
  }
}
