import 'package:flutter/material.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:gumpp/helpers/ad_helper.dart';

class AddWidg extends StatefulWidget {
  AddWidg();

  @override
  AddWidgState createState() => new AddWidgState();
}

class AddWidgState extends State<AddWidg> {
  // Burada normalde late vardı en başta. Onu kaldırmak sıkıntı çıkarır mı ?
  BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    ad_things();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  void ad_things() {
    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          //print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    if (_isBannerAdReady) {
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: _bannerAd.size.width.toDouble(),
          height: _bannerAd.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd),
        ),
      );
    } else {
      return Container();
    }
  }
}
