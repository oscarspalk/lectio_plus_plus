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
                itemCount: klasse.students.length * 2,
                itemBuilder: (context, index) {
                  if (index % 2 != 0) {
                    return Divider(
                      color: Theme.of(context).colorScheme.outline,
                    );
                  }

                  var student = snapshot.data!.students[(index / 2).floor()];

                  return ListTile(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            child: FutureBuilder(
                              future: student.getImage(student.imageId),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Image.memory(
                                    snapshot.data!,
                                    fit: BoxFit.fill,
                                  );
                                }
                                return const CircularProgressIndicator();
                              },
                            ),
                          );
                        },
                      );
                    },
                    leading: FutureBuilder(
                      future: student.getImage(student.imageId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CircleAvatar(
                            foregroundImage: MemoryImage(snapshot.data!),
                          );
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                    title: Text(student.name),
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
