

import 'package:flutter/material.dart';
import 'package:yd_lotto_provider/src/constant/ad_mob.dart';
import 'package:yd_lotto_provider/src/srceens/home/home.dart';
import 'package:yd_lotto_provider/src/srceens/search/search.dart';
import 'package:yd_lotto_provider/src/srceens/statistics/statistic.dart';

class BottomNaviView extends StatefulWidget {
  static const String routeName = '/bottom_navi';

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
        title: Text("Lotto",),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: new Icon(Icons.home), label: "홈", ),
          BottomNavigationBarItem(icon: new Icon(Icons.search), label: "명당"),
          BottomNavigationBarItem(
              icon: new Icon(Icons.help_outline_outlined), label: "생성"),
        ],
      ),
      body: _options.elementAt(_selectedIndex)
    );
  }



  @override
  void dispose() {
    super.dispose();
  }
}

