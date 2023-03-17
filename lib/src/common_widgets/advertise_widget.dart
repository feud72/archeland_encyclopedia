import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdvertiseWidget extends StatelessWidget {
  const AdvertiseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const adUnitId = 'ca-app-pub-4131087874978642/9220015326';
    const debugAdSampleUnitId = 'ca-app-pub-3940256099942544/6300978111';

    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        onAdLoaded: (_) {},
      ),
      size: AdSize.banner,
      adUnitId: kDebugMode ? debugAdSampleUnitId : adUnitId,
      request: const AdRequest(),
    );
    return FutureBuilder(
        future: banner.load(),
        builder: (context, AsyncSnapshot snapshot) {
          return AdWidget(ad: banner);
        });
  }
}
