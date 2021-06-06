import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';
import 'package:yd_lotto_provider/src/srceens/home/home.dart';
import 'package:yd_lotto_provider/src/srceens/number_make/number_make.dart';
import 'package:yd_lotto_provider/src/srceens/qr_code/qr_code.dart';
import 'package:yd_lotto_provider/src/srceens/search/search.dart';
import 'package:yd_lotto_provider/src/srceens/statistics/statistic.dart';

class BottomNaviView extends StatefulWidget {

  @override
  _BottomNaviViewState createState() => _BottomNaviViewState();
}

class _BottomNaviViewState extends State<BottomNaviView> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;

  static List<Widget> _options = <Widget>[
    HomeView(),
    SearchView(),
    NumberMakeView(),
    StatisticView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(
                  Icons.qr_code,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () async {
                  Get.to(() => QrCodeView());
                })
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          title: RichText(
              text: TextSpan(style: FontTheme.cR30Black, children: <TextSpan>[
                TextSpan(
                    text: "L",
                    style: FontTheme.cR30Black.copyWith(color: Colors.blueAccent)),
                TextSpan(
                    text: "o",
                    style: FontTheme.cR30Black
                        .copyWith(color: Colors.lightBlueAccent)),
                TextSpan(
                    text: "t",
                    style: FontTheme.cR30Black.copyWith(color: Colors.blueAccent)),
                TextSpan(
                    text: "t",
                    style: FontTheme.cR30Black.copyWith(color: Colors.blueAccent)),
                TextSpan(
                    text: "o",
                    style: FontTheme.cR30Black.copyWith(color: Colors.green)),
                TextSpan(
                    text: "6",
                    style: FontTheme.cR20Bold.copyWith(color: Colors.blueAccent)),
                TextSpan(
                    text: "/",
                    style: FontTheme.cR20Bold.copyWith(color: Colors.blueAccent)),
                TextSpan(
                    text: "45",
                    style: FontTheme.cR20Bold.copyWith(color: Colors.blueAccent)),
              ]))),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(icon: new Icon(Icons.search), label: "명당"),
          BottomNavigationBarItem(
              icon: new Icon(Icons.help_outline_outlined), label: "생성"),
          BottomNavigationBarItem(
              icon: new Icon(Icons.stacked_bar_chart), label: "통계"),
        ],
      ),
      body: Center(
        child: _options.elementAt(_selectedIndex),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}