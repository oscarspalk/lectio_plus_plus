import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lpp/payment/ad_free_state.dart';
import 'package:lpp/payment/owned_bloc.dart';
import 'package:lpp/topics/ads/bloc/ad_bloc.dart';

class AdBar extends StatefulWidget {
  const AdBar({super.key});

  @override
  State<AdBar> createState() => _AdBarState();
}

class _AdBarState extends State<AdBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnedCubit, AdFreeState>(builder: (context, state) {
      if (!(Platform.isAndroid || Platform.isIOS) || state.hasAdFree) {
        return const SizedBox(
          height: 0.0,
        );
      }
      return Container(
          color: kDebugMode ? Colors.yellow : null,
          width: double.infinity,
          height: 50.0,
          child: BlocBuilder<AdBloc, AdState>(
              builder: (BuildContext context, AdState state) {
            if (!state.loading && state.ad != null) {
              return AdWidget(ad: state.ad!);
            }
            return Container(
              color: kDebugMode ? Colors.green : null,
            );
          }));
    });
  }
}
