import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';
import 'package:yd_lotto_provider/src/providers/lotto_place_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_round_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_total_value_provider.dart';
import 'package:get/get.dart';

class CircularSlider extends StatefulWidget {
  @override
  _CircularSliderState createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  String selectedRound;

  @override
  void initState() {
    selectedRound =
        Provider.of<LottoRoundProvider>(context, listen: false).currentRound;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newRound = Provider.of<LottoRoundProvider>(context).currentRound;
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Text("원하는 회차를 선택해주세요",style: FontTheme.cR25Regular),
        SizedBox(
          height: 30,
        ),
        SleekCircularSlider(
          min: 1,
          max: double.parse(newRound),
          initialValue: double.parse(newRound),
          appearance: CircularSliderAppearance(
              spinnerDuration: 1500,
              customColors: CustomSliderColors(
                  trackColor: Colors.white70,
                  progressBarColors: [
                    Color(0xFFFF7171),
                    Color(0xFFF78686),
                    Color(0xFFE7B5C1),
                    Color(0xFFf7a3a3),
                    Color(0xFFFFFFFF),
                  ]),
              animDurationMultiplier: 0.7),
          onChange: (double value) {},
          onChangeStart: (double startValue) {},
          onChangeEnd: (double endValue) {
            selectedRound = endValue.toInt().toString();
          },
          innerWidget: (double value) {
            return Center(
                child: Container(
                    child: Text(
              value.toInt().toString() + " 회",
              style: FontTheme.cR30Regular,
            )));
          },
        ),
        GestureDetector(
            onTap: () async {
              Provider.of<LottoTotalProvider>(context, listen: false)
                  .getLottoValue(num: selectedRound);
              Provider.of<LottoPlaceProvider>(context, listen: false).getLottoPlace(num: selectedRound);
              Navigator.of(context).pop();
              Get.snackbar("업데이트", "업데이트 완료");
            },
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width*0.5,
              child: Center(child: Text("확인",style: FontTheme.cR30Regular,)),
            )),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
