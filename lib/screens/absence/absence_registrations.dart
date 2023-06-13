import 'package:flutter/material.dart';
import 'package:lpp/components/absence/absence_registration.dart';
import 'package:lpp/components/student_cache_loader.dart';

class AbsenceRegistrations extends StatelessWidget {
  const AbsenceRegistrations({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentCacheLoader(
      selector: (cache) {
        return cache.absence.listRegistrations();
      },
      builder: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return AbsenceRegistration(absenceCause: data[index]);
          },
        );
      },
    );
  }
}
