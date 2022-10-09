
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AnuncioBanner extends StatefulWidget {
  const AnuncioBanner({Key? key}) : super(key: key);

  @override
  State<AnuncioBanner> createState() => _AnuncioBannerState();
}

class _AnuncioBannerState extends State<AnuncioBanner> {

  void initState() {
  myBanner.load();
  super.initState();

}
final BannerAd myBanner = BannerAd(
  adUnitId: 'ca-app-pub-3940256099942544/6300978111',
  size: AdSize.banner,
  request: AdRequest(),
  listener: BannerAdListener(),
);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AdWidget(ad: myBanner),
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
    );
  }
}
