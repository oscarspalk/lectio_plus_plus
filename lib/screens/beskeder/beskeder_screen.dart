import 'package:flutter/material.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/error.dart';
import 'package:lpp/screens/loading.dart';
import 'package:provider/provider.dart';

class BeskederScreen extends StatelessWidget {
  const BeskederScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LectioModel>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: value.student!.messages.list(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("Der er ikke nogle beskeder 😃"),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data![index];
                  return ListTile(
                    title: Text(item.topic),
                  );
                },
              );
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
}
