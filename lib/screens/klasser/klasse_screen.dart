import 'package:flutter/material.dart';
import 'package:lectio_wrapper/types/class.dart';
import 'package:lpp/components/student_cache_loader.dart';
import 'package:lpp/screens/klasser/klasse_members_screen.dart';
import 'package:lpp/typograhy.dart';

class KlasseScreen extends StatelessWidget {
  const KlasseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentCacheLoader(
      selector: (cache) {
        return cache.classes.list();
      },
      builder: (data) {
        List<ClassRef> classes = data;
        return ListView.builder(
          itemCount: classes.length * 2,
          itemBuilder: (context, index) {
            if (index % 2 != 0) {
              return Divider(
                color: Theme.of(context).colorScheme.outline,
              );
            }

            var klasse = classes.elementAt((index / 2).floor());
            return ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return KlasseMembersScreen(klasseRef: klasse);
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
      },
    );
  }
}
