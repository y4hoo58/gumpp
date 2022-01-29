import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gumpp/helpers/ad_helper.dart';

class IntAdWidg {
  InterstitialAd interstitialAd;
  bool isInterstitialAdReady = false;

  // TODO: Implement _loadInterstitialAd()
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this.interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              //_moveToHome();
            },
          );

          isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          //print('Failed to load an interstitial ad: ${err.message}');
          isInterstitialAdReady = false;
        },
      ),
    );
  }
}
