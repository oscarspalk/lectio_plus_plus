import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const _androidTestId = "ca-app-pub-3940256099942544/6300978111";
const _iosTestId = "ca-app-pub-3940256099942544/2934735716";
const _androidProdId = "ca-app-pub-7673030582142706/1265058826";
const _iosProdId = "ca-app-pub-7673030582142706/8851904802";

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

sealed class AdEvent {}

final class DisposeAd extends AdEvent {}

class AdState {
  bool loading;
  BannerAd? ad;
  AdState(this.loading, this.ad);
}

class AdBloc extends Bloc<AdEvent, AdState> {
  late Timer timer;
  AdBloc(super.initialState) {
    timer = Timer.periodic(
      const Duration(seconds: 60),
      (timer) {
        add(DisposeAd());
      },
    );
    on<DisposeAd>(
      (event, emit) async {
        emit(state..loading = true);

        var ad = _loadAd(
          () async {
            debugPrint("impression");
          },
        );
        emit(AdState(false, ad));
      },
    );
  }
  final String _adUnitId = _decideId();

  BannerAd _loadAd(VoidCallback onImpression) {
    final ad = BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdImpression: (ad) {
          onImpression();
        },
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
}
