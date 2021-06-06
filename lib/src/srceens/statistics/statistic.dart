import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yd_lotto_provider/src/config/color_theme.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';
import 'package:yd_lotto_provider/src/models/lottoTotalModel.dart';
import 'package:yd_lotto_provider/src/providers/lotto_round_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_total_value_provider.dart';

class StatisticView extends StatefulWidget {
  @override
  _StatisticViewState createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  int _currentValue = 1;
  List<LottoTotalModel> _lottoTotalList = [];
  bool isLoading = false;
  List<NumberModel> numberModelList = [];

  List<FilterModel> filterModelList;

  //한달은 3
  //반기 9
  //분기 18
  //1년 36
  int selectedFilter = 3;

  @override
  void initState() {
    initFilterModel();
    initNumberModel();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLottoNumberList();
    });
  }

  void initFilterModel() {
    filterModelList = [
      FilterModel(title: "한달", isSelected: true, selectedDay: 3),
      FilterModel(title: "분기", isSelected: false, selectedDay: 9),
      FilterModel(title: "반기", isSelected: false, selectedDay: 18),
      FilterModel(title: "일년", isSelected: false, selectedDay: 36),
    ];
  }

  void initNumberModel() {
    numberModelList.clear();
    for (int i = 0; i <= 45; i++) {
      numberModelList.add(
        NumberModel(pKey: "$i", number: 0),
      );
    }
  }

  Future getLottoNumberList() async {
    setState(() {
      isLoading = true;
    });
    final lrp = Provider.of<LottoRoundProvider>(context, listen: false);
    final ltp = Provider.of<LottoTotalProvider>(context, listen: false);

    ltp.lottoTotalList.clear();
    _lottoTotalList.clear();

    _currentValue = int.parse(lrp.currentRound);
    //약 한달 간의 데이터를 얻기.
    for (int i = _currentValue - selectedFilter; i <= _currentValue; i++) {
      await ltp.getLottoNumberList(num: i.toString());
    }
    _lottoTotalList.addAll(ltp.lottoTotalList);
    initNumberModel(); //넘버 초기화
    separationNumber(); //데이터 쌓기.

    //pkey와 누적번호를
    numberModelList.sort((a, b) => b.number.compareTo(a.number));

    setState(() {
      isLoading = false;
    });
  }



  //삼중포문?
  void separationNumber() {
    _lottoTotalList.forEach((element) {
      increaseNumber(element.drwtNo1);
      increaseNumber(element.drwtNo2);
      increaseNumber(element.drwtNo3);
      increaseNumber(element.drwtNo4);
      increaseNumber(element.drwtNo5);
      increaseNumber(element.drwtNo6);
      increaseNumber(element.bnusNo);
    });
  }

  void increaseNumber(int value) {
    numberModelList[value].number += 1;
  }

  void setSelectedDayFilter(int value, int index) {
    filterModelList.forEach((element) {
      element.isSelected = false;
    });

    setState(() {
      filterModelList[index].isSelected = true;
      selectedFilter = value;
    });
    getLottoNumberList();
  }

  Widget setSelectedFilterWidget(
      String title, int day, bool isSelected, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.withOpacity(0.5), width: 2),
      ),
      child: TextButton(
          onPressed: () => setSelectedDayFilter(day, index),
          child: Text(
            title ?? "",
            style: FontTheme.cR35Regular
                .apply(color: isSelected ? Colors.blueAccent : Colors.grey),
          )),
    );
  }

  Color setNumberColor(int value) {
    if (value >= 1 && value <= 10) {
      return ColorTheme.cYellow;
    } else if (value >= 11 && value <= 20) {
      return ColorTheme.cBlue;
    } else if (value >= 21 && value <= 30) {
      return ColorTheme.cRed;
    } else if (value >= 31 && value <= 40) {
      return ColorTheme.cGrey;
    } else if (value >= 41 && value <= 45) {
      return ColorTheme.cGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CircularProgressIndicator();
    } else {
      return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: filterModelList
                    .map((e) => setSelectedFilterWidget(e.title, e.selectedDay,
                    e.isSelected, filterModelList.indexOf(e)))
                    .toList(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "동안 뽑힌 번호 통계",
                style: FontTheme.cR35Regular.copyWith(color: Colors.green),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Flexible(child: Container()),
                  Flexible(
                    flex: 7,
                    child: Column(
                      children: numberModelList
                          .map((e) => Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                e.pKey.toString() + "번은",
                                style: FontTheme.cR35Regular.copyWith(
                                    color:
                                    setNumberColor(int.parse(e.pKey))),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(e.number.toString() + "번 나옴",
                                  style: FontTheme.cR35Regular
                                      .copyWith(color: Colors.black54))
                            ],
                          ),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                  Flexible(child: Container()),
                ],
              )
            ],
          ));
    }
  }
}

class NumberModel {
  String pKey;
  int number;

  NumberModel({this.pKey, this.number});
}

class FilterModel {
  String title;
  bool isSelected;
  int selectedDay;

  FilterModel({this.title, this.isSelected, this.selectedDay});
}