import 'package:flutter/cupertino.dart';
import 'package:yd_lotto_provider/src/models/lottoPlaceModel.dart';
import 'package:yd_lotto_provider/src/models/lottoTotalModel.dart';
import 'package:yd_lotto_provider/src/services/http/http_service.dart';

class LottoTotalProvider extends ChangeNotifier {

  LottoTotalModel lottoValue;
  List<LottoTotalModel> lottoTotalList=[];
  LottoTotalProvider() {}

  Future initialize() async {
    lottoTotalList=[];
    await getLottoValue();
  }

  Future getLottoValue({String num}) async {
    LottoTotalModel lottoValueModel = await HttpService().getLottoTotalValue(req: num);
    lottoValue = lottoValueModel;
    notifyListeners();
  }

  Future getLottoNumberList({String num}) async {
    LottoTotalModel lottoValueModel = await HttpService().getLottoTotalValue(req: num);
    lottoTotalList.add(lottoValueModel);
  }




}