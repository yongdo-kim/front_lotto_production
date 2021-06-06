import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:yd_lotto_provider/src/config/color_theme.dart';
import 'package:yd_lotto_provider/src/config/font_theme.dart';
import 'package:yd_lotto_provider/src/constant/ad_mob.dart';
import 'package:yd_lotto_provider/src/global/widgets/bottom_widget.dart';
import 'package:yd_lotto_provider/src/providers/lotto_round_provider.dart';
import 'package:yd_lotto_provider/src/providers/lotto_total_value_provider.dart';
import 'package:yd_lotto_provider/src/srceens/home/widgets/lotto_balls.dart';
import 'package:yd_lotto_provider/src/srceens/home/widgets/home_round_widget.dart';
import 'package:yd_lotto_provider/src/utils/animations/digit_up.dart';
import 'package:yd_lotto_provider/src/utils/formats/number_format.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  int _currentValue = 1;
  int _fixedCurrentValue = 1;
  bool isLoading;





  @override
  void initState() {
    initLottoRound();

    super.initState();
  }






  void initLottoRound() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<LottoTotalProvider>(context, listen: false)
        .getLottoValue(num: "1");
    final result =
        Provider
            .of<LottoRoundProvider>(context, listen: false)
            .currentRound;
    setState(() {
      isLoading = false;
    });
    await Provider.of<LottoTotalProvider>(context, listen: false)
        .getLottoValue(num: result);
  }

  @override
  Widget build(BuildContext context) {
    final lrp = Provider.of<LottoRoundProvider>(context, listen: false);
    final ltp = Provider.of<LottoTotalProvider>(context, listen: false);

    _currentValue = int.parse(lrp.currentRound);

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
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
              child: CircularSlider(),
            );
          });
    }

    return !isLoading
        ? Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Column(
              children: [
          SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Column(
          children: [
            Text(
              "1등 당첨금액",
              style: FontTheme.cR30Bold,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<LottoTotalProvider>(
                  builder: (_, ltp, __) {
                    return AnimatedCount(
                      count: ltp.lottoValue.firstWinamnt.toInt(),
                      curve: Curves.ease,
                      duration: Duration(seconds: 1),
                    );
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text("원", style: FontTheme.cR30Regular),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        GestureDetector(
            onTap: () => settingModalBottomSheet(context),
            child: HomeRoundWidget()),
        SizedBox(
          height: 30,
        ),
        LottoBalls(),
          ],
        ),
    )
    :
    Center(
      child: CircularProgressIndicator
      (
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
