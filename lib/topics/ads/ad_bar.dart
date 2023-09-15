import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lpp/topics/ads/bloc/ad_bloc.dart';

class AdBar extends StatelessWidget {
  const AdBar({super.key});

  @override
  Widget build(BuildContext context) {
    if (!(Platform.isAndroid || Platform.isIOS)) {
      return const SizedBox(
        height: 0.0,
      );
    }
    return kDebugMode
        ? SizedBox(
            width: double.infinity,
            height: 50.0,
            child: BlocBuilder<AdBloc, AdState>(
              builder: (BuildContext context, AdState state) {
                if (state.current != null) {
                  return AdWidget(ad: state.current!);
                }
                return const SizedBox(
                  height: 0.0,
                );
              },
            ))
        : const SizedBox(
            width: double.infinity,
            height: 50.0,
          );
  }
}
