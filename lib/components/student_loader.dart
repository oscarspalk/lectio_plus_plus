import 'package:flutter/material.dart';
import 'package:lectio_wrapper/lectio/student.dart';
import 'package:lpp/model/lectio_model.dart';
import 'package:lpp/screens/error.dart';
import 'package:lpp/screens/loading.dart';
import 'package:provider/provider.dart';

class StudentLoader<T> extends StatelessWidget {
  final Widget Function(T data) builder;
  final Future<T> Function(Student student) selector;
  const StudentLoader(
      {super.key, required this.selector, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Consumer<LectioModel>(
      builder: (context, value, child) {
        return FutureBuilder(
          future: selector(value.student!),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return builder(snapshot.data as T);
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
