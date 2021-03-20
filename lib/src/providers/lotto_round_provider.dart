import 'package:flutter/cupertino.dart';
import 'package:yd_lotto_provider/src/models/lottoRoundModel.dart';
import 'package:yd_lotto_provider/src/services/http/http_service.dart';


class LottoRoundProvider extends ChangeNotifier {

   String currentRound;
   String fixedCurrentRound;


  LottoRoundProvider(){
  }

  Future initialize() async {
    await getNewRound();
  }

  Future getNewRound() async {
    LottoRoundModel result = await HttpService().getThisRound();
    currentRound = result.round;
    fixedCurrentRound = result.round;
  }

  void getCurrentRound({String round}){
    currentRound = round;
    notifyListeners();
  }
}
