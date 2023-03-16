import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdvertiseWidget extends StatelessWidget {
  const AdvertiseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const adUnitId = 'ca-app-pub-4131087874978642/9220015326';
    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {},
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: adUnitId,
      request: const AdRequest(),
    )..load();
    return AdWidget(ad: banner);
  }
}
