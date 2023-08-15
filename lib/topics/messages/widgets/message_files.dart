import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/primitives/file.dart';
import 'package:lpp/topics/modul/screens/modul_lektie_screen.dart';
import 'package:lpp/utils/ad_route.dart';
import 'package:lpp/widgets/layout/text_divider.dart';

class MessageFileRow extends StatelessWidget {
  const MessageFileRow({super.key, required this.files});
  final List<File>? files;
  @override
  Widget build(BuildContext context) {
    if (files == null) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const TextDivider(
          text: "Filer",
          primary: true,
        ),
        SizedBox(
          height: 40.0,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: files!.map((file) => FileChip(file: file)).toList(),
          ),
        ),
      ],
    );
  }
}

class FileChip extends StatelessWidget {
  const FileChip({super.key, required this.file});
  final File file;
  @override
  Widget build(BuildContext context) {
    return ActionChip(
        avatar: const Icon(EvaIcons.link2),
        onPressed: () {
          Navigator.push(
              context,
              adRoute(
                  ModulLektieScreen(
                      content: FileDetails(file.name, file.href, isFile: true)),
                  onlyFromEdge: true));
        },
        label: Text(file.name));
  }
}
