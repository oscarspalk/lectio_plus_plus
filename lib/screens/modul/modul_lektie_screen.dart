import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio_wrapper.dart';
import 'package:lectio_wrapper/types/calendar_event_details.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/error.dart';
import 'package:lpp/screens/loading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ModulLektieScreen extends StatefulWidget {
  final Content content;

  const ModulLektieScreen({super.key, required this.content});

  @override
  State<ModulLektieScreen> createState() => _ModulLektieScreenState();
}

class _ModulLektieScreenState extends State<ModulLektieScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> fetchFile(Student student) async {
    var fileContent =
        await student.getFile("https://lectio.dk${widget.content.href!}");
    var extension = widget.content.href!
        .substring(widget.content.href!.lastIndexOf(".") + 1);
    var dir = (await getTemporaryDirectory()).path;
    debugPrint("$dir/temp.$extension");
    File file = File("$dir/temp.$extension");
    await file.writeAsBytes(fileContent);
    return "$dir/temp.$extension";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LectioModel>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: fetchFile(value.student!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              launchUrl(Uri.parse("file:${snapshot.data!}"));
            }
            if (snapshot.hasError) {
              return const ErrorScreen();
            }
            return const LoadingScreen();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
