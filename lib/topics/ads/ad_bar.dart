import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBar extends StatefulWidget {
  const AdBar({super.key});

  @override
  State<AdBar> createState() => _AdBarState();
}

class _AdBarState extends State<AdBar> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    if (!kDebugMode) _loadAd();
  }

  final String _adUnitId = kDebugMode
      ? (Platform.isAndroid
          ? 'ca-app-pub-4763369128964093/1205778337'
          : 'ca-app-pub-3940256099942544/2934735716')
      : (Platform.isAndroid
          ? "ca-app-pub-4763369128964093/1205778337"
          : "ca-app-pub-4763369128964093/2170963928");

  void _loadAd() async {
    BannerAd(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    if (!(Platform.isAndroid || Platform.isIOS)) {
      return const SizedBox(
        height: 0.0,
      );
    }
    return !kDebugMode && _bannerAd != null
        ? SizedBox(
            width: double.infinity,
            height: 50.0,
            child: AdWidget(ad: _bannerAd!))
        : const SizedBox(
            width: double.infinity,
            height: 50.0,
          );
  }

  @override
  void dispose() {
    if (_bannerAd != null) {
      _bannerAd!.dispose();
    }
    super.dispose();
  }
}
