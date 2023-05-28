import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/loading.dart';
import 'package:provider/provider.dart';

class KlasseMembersScreen extends StatelessWidget {
  final ClassRef klasseRef;

  const KlasseMembersScreen({super.key, required this.klasseRef});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(klasseRef.name),
      ),
      body: Consumer<LectioModel>(builder: (ctx, value, widget) {
        return FutureBuilder(
          future: value.student!.getClass(klasseRef),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var klasse = snapshot.data!;
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
            return const LoadingScreen();
          },
        );
      }),
    );
  }
}
