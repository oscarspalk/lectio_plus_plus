import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  BannerAd? current;
  BannerAd? next;
  AdState(this.current, this.next);
}

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

class AdBloc extends Cubit<AdState> {
  AdBloc(super.initialState) {
    loadThisAndNext();
  }
  final String _adUnitId = _decideId();

  void loadThisAndNext() {
    if (Platform.isAndroid || Platform.isIOS) {
      if (state.current == null) {
        _loadAd((ad) => emit(AdState(ad, state.next)));
        _loadAd((ad) => emit(AdState(state.current, ad)));
      } else {
        emit(AdState(state.next, null));
        _loadAd((ad) => emit(AdState(state.current, ad)));
      }
    }
  }

  void _loadAd(Function(BannerAd ad) onLoaded) {
    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) => onLoaded(ad as BannerAd),
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }
}
