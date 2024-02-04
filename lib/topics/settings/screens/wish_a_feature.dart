import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/style/typograhy.dart';
import 'package:lpp/topics/welcome/widgets/illustration.dart';
import 'package:lpp/widgets/layout/appbar.dart';

import '../bloc/feature_request.dart';

class WishAFeatureScreen extends StatefulWidget {
  const WishAFeatureScreen({super.key});

  @override
  State<WishAFeatureScreen> createState() => _WishAFeatureScreenState();
}

class _WishAFeatureScreenState extends State<WishAFeatureScreen> {
  late FeatureRequestBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = FeatureRequestBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const LppAppbar(
          title: "Ønsk en feature",
        ),
        body: BlocBuilder<FeatureRequestBloc, FeatureRequestState>(
          bloc: bloc,
          builder: (context, state) {
            if (state.submitted) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Illustration(illustration: "a_whole_year"),
                  Text(
                    "Tusind tak",
                    style: headerStyle,
                  )
                ],
              );
            }

            return ListView(padding: const EdgeInsets.all(24.0), children: [
              const Illustration(illustration: "wishes"),
              TextField(
                onChanged: bloc.setTopic,
                decoration: const InputDecoration(label: Text("Emne")),
              ),
              TextField(
                onChanged: bloc.setContent,
                minLines: 1,
                maxLines: 7,
                decoration: const InputDecoration(label: Text("Indhold")),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilledButton(
                    onPressed: state.valid ? bloc.submit : null,
                    child: const Text("Send")),
              )
            ]);
          },
        ));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
