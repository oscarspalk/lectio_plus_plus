import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';

class KlasseMembersScreen extends StatelessWidget {
  final Class klasse;

  const KlasseMembersScreen({super.key, required this.klasse});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: klasse.students.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: klasse.students[index].getBasicInfo(),
          builder: (context, snapshot) {
            return ListTile(
              title: snapshot.hasData
                  ? Text(snapshot.data!.name)
                  : const CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}
