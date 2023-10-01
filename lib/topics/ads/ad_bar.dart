import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lpp/topics/ads/bloc/ad_bloc.dart';

class AdBar extends StatefulWidget {
  const AdBar({super.key});

  @override
  State<AdBar> createState() => _AdBarState();
}

class _AdBarState extends State<AdBar> {
  late AdBloc _adBloc;

  @override
  void initState() {
    super.initState();
    _adBloc = context.read<AdBloc>();
  }

  @override
  Widget build(BuildContext context) {
    if (!(Platform.isAndroid || Platform.isIOS)) {
      return const SizedBox(
        height: 0.0,
      );
    }
    return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: BlocBuilder<AdBloc, AdState>(
          bloc: _adBloc,
          builder: (BuildContext context, AdState state) {
            if (!state.loading && state.ad != null) {
              return AdWidget(ad: state.ad!);
            }
            return const SizedBox(
              height: 0.0,
            );
          },
        ));
  }

  @override
  void dispose() {
    _adBloc.add(DisposeAd());
    super.dispose();
  }
}
