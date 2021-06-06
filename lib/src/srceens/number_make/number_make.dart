import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yd_lotto_provider/src/config/color_theme.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';
import 'package:yd_lotto_provider/src/global/widgets/lottoball.dart';
import 'dart:math';

class NumberMakeView extends StatefulWidget {

  @override
  _NumberMakeViewState createState() => _NumberMakeViewState();
}

class _NumberMakeViewState extends State<NumberMakeView>
    with TickerProviderStateMixin {
  Set<int> randomSet = Set();
  List<LottoBallInfo> selectedNumberList = List<LottoBallInfo>();
  bool isCompleteNumberList = false;

  AnimationController rotateAniController;

  @override
  void initState() {
    getRandomNumberList();
    rotateAniInit();
    super.initState();
  }

  void rotateAniInit() {
    rotateAniController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 7),
    );

    rotateAniController.repeat();
  }

  @override
  void dispose() {
    rotateAniController.dispose();
    super.dispose();
  }

  void getRandomNumberList() {
    randomSet.clear();
    Random random = new Random();
    while (randomSet.length != 6) {
      randomSet.add(random.nextInt(45) + 1); // 1-45
    }
  }

  void numberClear() {
    setState(() {
      getRandomNumberList();
      selectedNumberList.clear();
      isCompleteNumberList = false;
    });
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: [
            Flexible(
              flex: 8,
              child: Center(
                  child: Column(

                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFFF7171), width: 3),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: Text(
                                  "?",
                                  style: FontTheme.cR20Regular.apply(color: Colors.black87),
                                )),
                          ),
                          SizedBox(width: 10,),
                          Text("를 끌어서", style: FontTheme.cR25Regular.apply(color: Colors.black87),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: DottedDecoration(
                                shape: Shape.circle,
                                dash: <int>[5, 10],
                                color: Color(0xFFFF7171),
                                strokeWidth: 3),
                            width: 50,
                            height: 50,
                          ),
                          SizedBox(width: 10,),
                          Text("에 넣어주세요", style: FontTheme.cR25Regular.apply(color: Colors.black87),),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "6개의 로또 번호를 생성해요",
                        textAlign: TextAlign.center,
                        style: FontTheme.cR15Regular.apply(color: Colors.grey),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: [
                                Draggable(
                                    data: randomSet.first,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFFF7171), width: 3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                          child: Text(
                                            "?",
                                            style: FontTheme.cR40Regular
                                                .apply(color: Colors.black87),
                                          )),
                                    ),
                                    feedback: Container(
                                        width: 120,
                                        height: 120,
                                        child: LottoBall(
                                          num: randomSet.first,
                                          textStyle: FontTheme.cR40Regular
                                              .apply(color: Colors.white),
                                        ))),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${randomSet.length} 번 남았어요!",
                                  textAlign: TextAlign.center,
                                  style: FontTheme.cR20Regular
                                      .apply(color: Colors.black87),
                                ),
                              ],
                            ),
                            AnimatedBuilder(
                              builder: (BuildContext context, Widget _widget) {
                                return new Transform.rotate(
                                  angle: rotateAniController.value * 6.3,
                                  child: _widget,
                                );
                              },
                              animation: rotateAniController,
                              child: Container(
                                decoration: DottedDecoration(
                                    shape: Shape.circle,
                                    dash: <int>[5, 10],
                                    color: Color(0xFFFF7171),
                                    strokeWidth: 3),
                                width: 100.0,
                                height: 100.0,
                                child: DragTarget(
                                  builder:
                                      (context, List<int> candidateData, rejectedData) {
                                    return Container();
                                  },
                                  onWillAccept: (data) {
                                    return true;
                                  },
                                  onAccept: (data) {
                                    selectedNumberList.add(LottoBallInfo(
                                        num: data, color: SetBallColor(num: data)));
                                    setState(() {
                                      if (randomSet.length > 1) {
                                        randomSet.remove(data);
                                      } else {
                                        isCompleteNumberList = true;
                                      }
                                    });

                                    if (isCompleteNumberList) {
                                      Get.dialog(AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(5)),
                                        title: Text('생성된 로또번호',
                                            style: FontTheme.cR25Regular),
                                        content: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: selectedNumberList
                                              .map((data) => Padding(
                                              padding:
                                              EdgeInsets.only(left: 5),
                                              child: Text(
                                                data.num.toString(),
                                                style: FontTheme.cR20Regular
                                                    .apply(
                                                    color: data.color),
                                              )))
                                              .toList(),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              numberClear();
                                              // cancelFunc();
                                            },
                                            child: Text(
                                              '다시하기',
                                              style: FontTheme.cR15Regular
                                                  .apply(color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),);
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: selectedNumberList
                            .map((data) => Container(
                            width: 70,
                            height: 70,
                            child: LottoBall(
                              num: data.num,
                              textStyle: FontTheme.cR20Regular
                                  .apply(color: Colors.white),
                            )))
                            .toList(),
                      )),
                ))
          ],
        ));
  }
}

class LottoBallInfo {
  final int num;
  final Color color;

  LottoBallInfo({this.num, this.color});
}

Color SetBallColor({int num}) {
  if (num >= 1 && num <= 10) {
    return ColorTheme.cYellow;
  } else if (num >= 11 && num <= 20) {
    return ColorTheme.cBlue;
  } else if (num >= 21 && num <= 30) {
    return ColorTheme.cRed;
  } else if (num >= 31 && num <= 40) {
    return ColorTheme.cGrey;
  } else if (num >= 41 && num <= 45) {
    return ColorTheme.cGreen;
  }
}