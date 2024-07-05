import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lectio_wrapper/types/terms/term.dart';
import 'package:lpp/routing/router.dart';
import 'package:lpp/topics/settings/bloc/term_bloc.dart';
import 'package:lpp/utils/ad_route.dart';

class ChangeYearScreen extends StatelessWidget {
  const ChangeYearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: BlocBuilder<TermBloc, List<Term>?>(builder: (context, state) {
        var selected = state?.where((term) => term.active).firstOrNull;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: (state ?? <Term>[]).map(
            (e) {
              return RadioListTile<Term>(
                title: Text(e.name),
                value: e,
                groupValue: selected,
                onChanged: (value) {
                  if (value != null && !value.active) {
                    var bloc = context.read<TermBloc>();
                    bloc.set(value);

                    Navigator.pushReplacement(
                        context, adRoute(const AppRouter()));
                  }
                },
              );
            },
          ).toList(),
        );
      }),
    );
  }
}
