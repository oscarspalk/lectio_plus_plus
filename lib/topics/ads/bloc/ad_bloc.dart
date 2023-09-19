import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  BannerAd? current;
  BannerAd? next;
  AdState(this.current, this.next);
}

class AdBloc extends Cubit<AdState> {
  AdBloc(super.initialState) {
    loadThisAndNext();
  }
  final String _adUnitId = kDebugMode
      ? (Platform.isAndroid
          ? 'ca-app-pub-4763369128964093/1205778337'
          : 'ca-app-pub-3940256099942544/2934735716')
      : (Platform.isAndroid
          ? "ca-app-pub-7673030582142706/1265058826"
          : "ca-app-pub-4763369128964093/2170963928");

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
        // Called when an ad is successfully received.
        onAdLoaded: (ad) => onLoaded(ad as BannerAd),
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }
}
