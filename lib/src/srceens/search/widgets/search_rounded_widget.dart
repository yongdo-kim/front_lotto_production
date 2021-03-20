import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';
import 'package:yd_lotto_provider/src/providers/lotto_place_provider.dart';

import 'package:yd_lotto_provider/src/providers/lotto_total_value_provider.dart';

class SearchRoundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LottoPlaceProvider, LottoTotalProvider>(
      builder: (_, lpp,ltp, __) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffFFFFFF),
                    Color(0xFFE7B5C1),
                  ],
                ),
                border: Border.all(color:   Color(0xFFE7B5C1), width:1),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ltp.lottoValue.drwNo.toString() +" 회",
                  style: FontTheme.cR20Regular,
                ),
                SizedBox(height: 5,),
                Text("1등 당첨 판매점", style: FontTheme.cR20Regular,),
              ],
            )
          ),
        );
      },
    );
  }
}
