import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';
import 'package:yd_lotto_provider/src/global/widgets/admob_banner.dart';
import 'package:yd_lotto_provider/src/global/widgets/bottom_widget.dart';
import 'package:yd_lotto_provider/src/models/lottoPlaceModel.dart';
import 'package:yd_lotto_provider/src/providers/lotto_place_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_total_value_provider.dart';
import 'package:yd_lotto_provider/src/srceens/map/google_map.dart';

import 'package:yd_lotto_provider/src/srceens/search/widgets/search_rounded_widget.dart';

class SearchView extends StatefulWidget {
  static const String routeName = '/search';

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {

  @override
  Widget build(BuildContext context) {
    YYDialog.init(context);
    void settingModalBottomSheet(context) {
      showModalBottomSheet(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          context: context,
          builder: (BuildContext bc) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: CircularSlider(),
            );
          });
    }

    return Consumer2<LottoPlaceProvider, LottoTotalProvider>(
      builder: (_, lpp, ltp, __) {
        return lpp.lottoPlaceList != null
            ? Stack(
          children: [
            SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () => settingModalBottomSheet(context),
                        child: SearchRoundWidget()),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: lpp.lottoPlaceList
                            .map((data) => placeInfo(
                            data, context, lpp.lottoPlaceList.indexOf(data)))
                            .toList())
                  ],
                )),
            Column(
              children: [
                Expanded(child: Container(),),
                AdmobBannerWidget(),
              ],
            )
          ],
        )
            :Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 20, right: 30),
                child: Container(
                  child: Text(
                    ltp.lottoValue.drwNo.toString() + "회차\n주소 정보가 없어요!",
                    style: FontTheme.cR40Regular,
                  ),
                ),
              ),
            Column(
              children: [
                Expanded(child: Container(),),
                AdmobBannerWidget(),
              ],
            )
          ],
        );
      },
    );
  }
}



Widget placeInfo(LottoPlaceModel data, BuildContext context, int colorIndex) {
  int tempIndex = colorIndex % 5;
  Color selectedColor;

  if (tempIndex == 0) {
    selectedColor = Color(0xFFFBC300);
  } else if (tempIndex == 1) {
    selectedColor = Color(0xFF6AC8F2);
  } else if (tempIndex == 2) {
    selectedColor = Color(0xFFFF7171);
  } else if (tempIndex == 3) {
    selectedColor = Color(0xFFAAAAAA);
  } else if (tempIndex == 4) {
    selectedColor = Color(0xFFB0D940);
  }

  return InkWell(
    onTap: () => placeDialog(data, context),
    child: Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: selectedColor, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: Center(
            child: Text(
          data.placeName,
          style: FontTheme.cR20Regular,
        )),
      ),
    ),
  );
}

YYDialog placeDialog(LottoPlaceModel data, BuildContext context) {
  return YYDialog().build()
    ..width = MediaQuery.of(context).size.width * 0.8
    ..borderRadius = 10.0
    ..showCallBack = () {}
    ..dismissCallBack = () {}
    ..widget(Container(
        color: Colors.white,
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("오늘도 1등",
                                  style: FontTheme.cR10Regular
                                      .apply(color: Colors.black)),
                              Row(
                                children: [
                                  Text("Lotto",
                                      style: FontTheme.cR25Bold
                                          .apply(color: Colors.black)),
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
                          Image.asset('assets/images/lotto_qrcode.png',
                              width: 50.0, height: 50.0),
                        ],
                      ),
                      Consumer<LottoTotalProvider>(
                        builder: (_, ltp, __) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "제 ${ltp.lottoValue.drwNo} 회",
                                style: FontTheme.cR15Regular,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "추첨일 : ",
                                    style: FontTheme.cR15Regular,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    ltp.lottoValue.drwNoDate,
                                    style: FontTheme.cR15Regular,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    data.place,
                                    style: FontTheme.cR15Regular,
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFFE7B5C1), width: 1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Center(
                                    child: Text("매장 찾기",
                                        style: FontTheme.cR20Regular
                                            .apply(color: Colors.black)),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GoogleMapViw(),
                                      settings: RouteSettings(
                                        arguments: data.place,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
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
        )))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

