import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';
import 'package:yd_lotto_provider/src/providers/lotto_round_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_total_value_provider.dart';

class HomeRoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LottoTotalProvider>(
      builder: (_, ltp, __) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffFFFFFF),
                    Color(0xFFE7B5C1),
                  ],
                ),
                border: Border.all(color: Colors.black, width: 0.1),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Center(
                child:  Text(
                  ltp.lottoValue.drwNo.toString() +" 회",
                  style: FontTheme.cR30Regular,
                )),
          ),
        );
      },
    );
  }
}
