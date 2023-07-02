import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lpp/logic/bloc/feature/feature_request.dart';
import 'package:lpp/ui/style/typograhy.dart';
import 'package:lpp/ui/widgets/layout/appbar.dart';
import 'package:lpp/ui/widgets/welcome/illustration.dart';
import 'package:ms_undraw/ms_undraw.dart';

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
        appBar: LppAppbar(
          title: "Ønsk en feature",
          oldContext: context,
        ),
        body: BlocBuilder<FeatureRequestBloc, FeatureRequestState>(
          bloc: bloc,
          builder: (context, state) {
            if (state.submitted) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Illustration(
                      illustration: UnDrawIllustration.a_whole_year),
                  Text(
                    "Tusind tak",
                    style: headerStyle,
                  )
                ],
              );
            }

            return ListView(padding: const EdgeInsets.all(24.0), children: [
              const Illustration(illustration: UnDrawIllustration.wishes),
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
