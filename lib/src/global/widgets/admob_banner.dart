import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:yd_lotto_provider/src/constant/ad_mob.dart';

class AdmobBannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return     Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child: AdmobBanner(
            adUnitId: 'ca-app-pub-3940256099942544/2934735716',
            // adUnitId: 'ca-app-pub-2398130378795170/1239956483',
            // test adUnit Id
            adSize: AdmobBannerSize.BANNER,
            listener: (AdmobAdEvent event, Map<String, dynamic> args) {
              print(event);
              print(args);
            }
        ));
  }
}

