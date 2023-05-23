import 'package:flutter/material.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/error.dart';
import 'package:lpp/screens/loading.dart';
import 'package:provider/provider.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LectioModel>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.student!.getHomework(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const ErrorScreen();
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("Der ikke er nogle lektier til dig. 😘"),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var homework = snapshot.data![index];
                  return ListTile(
                    title: Text(homework.activity),
                  );
                },
              );
            } else {
              return const LoadingScreen();
            }
          },
        );
      },
    );
  }
}
