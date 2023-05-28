import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/assignment.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/helpers.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/error.dart';
import 'package:lpp/screens/klasser/klasse_members_screen.dart';
import 'package:lpp/screens/loading.dart';
import 'package:lpp/typograhy.dart';
import 'package:provider/provider.dart';

class KlasseScreen extends StatelessWidget {
  const KlasseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LectioModel>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.student!.getClasses(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const ErrorScreen();
            }
            if (snapshot.hasData && snapshot.data != null) {
              List<Class> classes = snapshot.data!;
              return ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  var klasse = classes.elementAt(index);
                  return ListTile(
                    tileColor:
                        Theme.of(context).colorScheme.surface.withOpacity(0.5),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return KlasseMembersScreen(klasse: klasse);
                        },
                      ));
                    },
                    title: Text(
                      klasse.name,
                      style: headerStyle,
                    ),
                  );
                },
              );
            }
            return const LoadingScreen();
          },
        );
      },
    );
  }
}
