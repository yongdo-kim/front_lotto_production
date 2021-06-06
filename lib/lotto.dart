import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:yd_lotto_provider/src/config/color_theme.dart';
import 'package:yd_lotto_provider/src/providers/lotto_place_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_round_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_total_value_provider.dart';
import 'package:yd_lotto_provider/src/srceens/bottomNavi/bottom_navi.dart';
import 'package:yd_lotto_provider/src/srceens/home/home.dart';
import 'package:yd_lotto_provider/src/srceens/map/google_map.dart';
import 'package:yd_lotto_provider/src/srceens/number_make/number_make.dart';
import 'package:yd_lotto_provider/src/srceens/qr_code/qr_code.dart';
import 'package:yd_lotto_provider/src/srceens/search/search.dart';
import 'package:yd_lotto_provider/src/srceens/splash/splash.dart';
import 'package:yd_lotto_provider/src/srceens/statistics/statistic.dart';

class LottoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LottoRoundProvider>(
            create: (_) => LottoRoundProvider()),
        ChangeNotifierProvider<LottoTotalProvider>(
            create: (_) => LottoTotalProvider()),
        ChangeNotifierProvider<LottoPlaceProvider>(
            create: (_) => LottoPlaceProvider()),
      ],
      child: GetMaterialApp(
        builder: (BuildContext context, Widget child) {
          child = MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child,
          );
          return child;
        },
        title: 'Lotto',
        theme: buildColorTheme(),
        home: SplashView(),
        getPages: [
          GetPage(name: '/', page: () => SplashView()),
          GetPage(name: '/bottom_navi', page: () => BottomNaviView()),
          GetPage(name: '/home', page: () => HomeView()),
          GetPage(name: '/search', page: () => SearchView()),
          GetPage(name: '/statics', page: () => NumberMakeView()),
          GetPage(name: '/google_map', page: () => GoogleMapViw()),
          GetPage(name: '/qr_code', page: () => QrCodeView()),
        ],
      ),
    );
  }
}
