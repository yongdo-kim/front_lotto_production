import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';
import 'package:yd_lotto_provider/src/providers/lotto_place_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_round_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_total_value_provider.dart';
import 'package:yd_lotto_provider/src/srceens/bottomNavi/bottom_navi.dart';

class SplashView extends StatefulWidget {

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  static final AdRequest request = AdRequest(
    testDevices: <String>['ca-app-pub-2398130378795170/4653550280'],
  );
  InterstitialAd _interstitialAd;
  bool _interstitialReady = false;


  @override
  initState() {
    initProvider();

    MobileAds.instance.initialize().then((InitializationStatus status) {
      print('Initialization done: ${status.adapterStatuses}');
      MobileAds.instance
          .updateRequestConfiguration(RequestConfiguration(
          tagForChildDirectedTreatment:
          TagForChildDirectedTreatment.unspecified))
          .then((void value) {
        createInterstitialAd();
      });
    });

    super.initState();
  }

  Future createInterstitialAd() async{
    _interstitialAd ??= InterstitialAd(
      adUnitId: 'ca-app-pub-2398130378795170/4653550280',
      request: request,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('${ad.runtimeType} loaded.');
          setState(() {
            _interstitialReady = true;
          });
          if(_interstitialReady){
            _interstitialAd.show();
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('${ad.runtimeType} failed to load: $error.');
          ad.dispose();
          _interstitialAd = null;
          createInterstitialAd();
        },
        onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
        onAdClosed: (Ad ad) {
          print('${ad.runtimeType} closed.');
          ad.dispose();
          createInterstitialAd();
        },
        onApplicationExit: (Ad ad) =>
            print('${ad.runtimeType} onApplicationExit.'),
      ),
    )..load();
  }

  void initProvider() async {
    //지도 퍼미션
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
    print(statuses[Permission.location]);

    //데이터 가져오기
    await Future.wait([
      Provider.of<LottoRoundProvider>(context, listen: false).initialize(),
      Provider.of<LottoPlaceProvider>(context, listen: false).initialize(),
      Provider.of<LottoTotalProvider>(context, listen: false).initialize(),
    ]).then((value) => navigateToHomeView());
  }

  Future<void> navigateToHomeView() async {
    await Get.off(() => BottomNaviView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFFF7171), width: 0.5),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 10,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Lotto",
                                          style: FontTheme.cR20Bold
                                              .apply(color: Color(0xFFE7B5C1)),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("6/45",
                                            style: FontTheme.cR15Bold
                                                .apply(color: Color(0xFFE7B5C1)))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text("오늘도 1등",
                                                style: FontTheme.cR10Regular
                                                    .apply(color: Colors.black)),
                                            Row(
                                              children: [
                                                Text("Lotto",
                                                    style: FontTheme.cR25Bold.apply(
                                                        color: Colors.black)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("6/45",
                                                    style: FontTheme.cR15Regular
                                                        .apply(color: Colors.black))
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Image.asset(
                                            'assets/images/lotto_qrcode.png',
                                            width: 50.0,
                                            height: 50.0),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "오늘의 로또",
                                          style: FontTheme.cR15Regular,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "추첨일 : ${DateTime.now().year}년 ${DateTime.now().month}월 ${DateTime.now().day}일 ",
                                              style: FontTheme.cR15Regular,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "위치  :  ",
                                              style: FontTheme.cR15Regular,
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Expanded(
                                                child: Text(
                                                  "내가 사러 가는 곳",
                                                  style: FontTheme.cR15Regular,
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xFFE7B5C1),
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5))),
                                          child: Center(
                                            child: Text("행운의 주인공은?",
                                                style: FontTheme.cR20Regular
                                                    .apply(color: Colors.black)),
                                          ),
                                          width: MediaQuery.of(context).size.width,
                                          height: 60,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.height * 0.5,
                                color: Color(0xFFE7B5C1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    RotatedBox(
                                      quarterTurns: 1,
                                      child: RichText(
                                        text: TextSpan(
                                            text: '** 1등 기원! 행복한 하루 보내세요! **',
                                            style: FontTheme.cR15Regular
                                                .apply(color: Colors.white)),
                                      ),
                                    ),
                                  ],
                                )),
                          )
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  "로또6",
                  style: FontTheme.cR30Regular,
                ),
              ),
            ],
          ),
        ));
  }
}