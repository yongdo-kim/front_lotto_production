import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';
import 'package:yd_lotto_provider/src/global/widgets/lottoball.dart';
import 'package:yd_lotto_provider/src/models/lottoTotalModel.dart';
import 'package:yd_lotto_provider/src/providers/lotto_total_value_provider.dart';

class LottoBalls extends StatefulWidget {
  @override
  _LottoBallsState createState() => _LottoBallsState();
}

class _LottoBallsState extends State<LottoBalls> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Consumer<LottoTotalProvider>(builder: (_, ltp, __) {
      LottoTotalModel ball = ltp.lottoValue;
      return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          children: <Widget>[
            LottoBall(
              num: ball.drwtNo1,
              textStyle: FontTheme.cR20Regular.apply(color: Colors.white),
            ),
            LottoBall(
              num: ball.drwtNo2,
              textStyle: FontTheme.cR20Regular.apply(color: Colors.white),
            ),
            LottoBall(
              num: ball.drwtNo3,
              textStyle: FontTheme.cR20Regular.apply(color: Colors.white),
            ),
            LottoBall(
              num: ball.drwtNo4,
              textStyle: FontTheme.cR20Regular.apply(color: Colors.white),
            ),
            LottoBall(
              num: ball.drwtNo5,
              textStyle: FontTheme.cR20Regular.apply(color: Colors.white),
            ),
            LottoBall(
              num: ball.drwtNo6,
              textStyle: FontTheme.cR20Regular.apply(color: Colors.white),
            ),
            Icon(
              Icons.add,
              size: 40,
            ),
            LottoBall(
              num: ball.bnusNo,
              textStyle: FontTheme.cR20Regular.apply(color: Colors.white),
            ),
          ],
        ),
      );
    });
  }
}

