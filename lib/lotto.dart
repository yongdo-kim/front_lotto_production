import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yd_lotto_provider/src/config/color_theme.dart';
import 'package:yd_lotto_provider/src/providers/lotto_place_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_round_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_total_value_provider.dart';
import 'package:yd_lotto_provider/src/srceens/bottomNavi/bottom_navi.dart';
import 'package:yd_lotto_provider/src/srceens/home/home.dart';
import 'package:yd_lotto_provider/src/srceens/map/google_map.dart';
import 'package:yd_lotto_provider/src/srceens/search/search.dart';
import 'package:yd_lotto_provider/src/srceens/splash/splash.dart';
import 'package:yd_lotto_provider/src/srceens/statistics/statistic.dart';

class LottoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LottoRoundProvider>(
            create: (_) => LottoRoundProvider()),
        ChangeNotifierProvider<LottoTotalProvider>(
            create: (_) => LottoTotalProvider()),
        ChangeNotifierProvider<LottoPlaceProvider>(
            create: (_) => LottoPlaceProvider()),
      ],
      child: MaterialApp(
        builder: (BuildContext context, Widget child) {
          child = botToastBuilder(context, child);
          child = MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: child,
          );
          return child;
        },
        title: 'Lotto',
        theme: buildColorTheme(),
        home: SplashView(),
        navigatorObservers: [BotToastNavigatorObserver()],
        routes: {
          SplashView.routeName: (context) => SplashView(),
          BottomNaviView.routeName: (context) => BottomNaviView(),
          HomeView.routeName: (context) => HomeView(),
          SearchView.routeName: (context) => SearchView(),
          StatisticView.routeName: (context) => StatisticView(),
          GoogleMapViw.routeName: (context) => GoogleMapViw()
        },
      ),
    );
  }
}
