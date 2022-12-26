import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:notify_app/model/lectio_model.dart';
import 'package:notify_app/screens/homework.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<LectioModel>(builder: (context, value, child) {
      return Scaffold(
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                _selectedIndex = value;
              });
            },
            destinations: const [
              NavigationDestination(
                  icon: Icon(EvaIcons.calendar), label: "Skema"),
              NavigationDestination(
                  icon: Icon(EvaIcons.bookOpenOutline), label: "Lektier")
            ],
          ),
          appBar: AppBar(
            title: const Text(
              "Lectio++",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    await value.signOut();
                  },
                  icon: Icon(EvaIcons.logOut))
            ],
          ),
          body: <Widget>[Container(), HomeworkScreen()][_selectedIndex]);
    });
  }
}
