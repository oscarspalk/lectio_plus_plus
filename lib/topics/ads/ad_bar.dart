import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lpp/payment/ad_free_state.dart';
import 'package:lpp/payment/owned_bloc.dart';

const _androidTestId = "ca-app-pub-3940256099942544/6300978111";
const _iosTestId = "ca-app-pub-3940256099942544/2934735716";
const _androidProdId = "ca-app-pub-2657809018485943/6317642741";
const _iosProdId = "ca-app-pub-2657809018485943/8228484628";

String _decideId() {
  var isAndroid = Platform.isAndroid;
  if (kDebugMode) {
    if (isAndroid) {
      return _androidTestId;
    } else {
      return _iosTestId;
    }
  }
  if (isAndroid) {
    return _androidProdId;
  }
  return _iosProdId;
}

class AdBar extends StatefulWidget {
  const AdBar({super.key});

  @override
  State<AdBar> createState() => _AdBarState();
}

class _AdBarState extends State<AdBar> {
  final String _adUnitId = _decideId();

  late BannerAd ad;

  BannerAd _loadAd() {
    final ad = BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint("Loaded ad");
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
          debugPrint(err.message);
        },
      ),
    );
    ad.load();
    return ad;
  }

  @override
  void initState() {
    super.initState();
    ad = _loadAd();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
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
            child: AdWidget(ad: ad));
      });
    });
  }

  @override
  void dispose() {
    ad.dispose();
    super.dispose();
  }
}
