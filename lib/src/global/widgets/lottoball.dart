import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yd_lotto_provider/src/config/color_theme.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';
import 'package:yd_lotto_provider/src/providers/lotto_round_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_total_value_provider.dart';

class LottoBall extends StatefulWidget {
  final int num;
  final TextStyle textStyle;

  LottoBall({this.num, this.textStyle});

  @override
  _LottoBallState createState() => _LottoBallState();
}

class _LottoBallState extends State<LottoBall> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> offsetAnimation;
  Color selectedColor;

  @override
  void initState() {
    ballAnimation();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void ballAnimation() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
    offsetAnimation = Tween(begin: -4.0, end: 4.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });
    controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.num >= 1 && widget.num <= 10) {
      selectedColor = ColorTheme.cYellow;
    } else if (widget.num >= 11 && widget.num <= 20) {
      selectedColor = ColorTheme.cBlue;
    } else if (widget.num >= 21 && widget.num <= 30) {
      selectedColor = ColorTheme.cRed;
    } else if (widget.num >= 31 && widget.num <= 40) {
      selectedColor = ColorTheme.cGrey;
    } else if (widget.num >= 41 && widget.num <= 45) {
      selectedColor = ColorTheme.cGreen;
    }

    void getCurrentRound() async {
      await Provider.of<LottoTotalProvider>(context, listen: false)
          .getLottoValue(num: "1");
      final result =
          Provider.of<LottoRoundProvider>(context, listen: false).currentRound;
      await Provider.of<LottoTotalProvider>(context, listen: false)
          .getLottoValue(num: result);
    }

    return GestureDetector(
        onTap: () async {
          controller.forward(from: 0.0);
          getCurrentRound();
        },
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: AnimatedBuilder(
                    animation: offsetAnimation,
                    builder: (_, child) {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: offsetAnimation.value + 8.0,
                            bottom: 8.0 - offsetAnimation.value),
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ], shape: BoxShape.circle, color: selectedColor),
                          child: Center(
                              child: Text(
                            widget.num.toString(),
                            style: widget.textStyle,
                          )),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
