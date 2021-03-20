import 'package:flutter/cupertino.dart';
import 'package:yd_lotto_provider/src/models/lottoPlaceModel.dart';
import 'package:yd_lotto_provider/src/models/lottoRoundModel.dart';
import 'package:yd_lotto_provider/src/services/http/http_service.dart';
import 'package:yd_lotto_provider/src/services/http/request/lotto_place_req.dart';

class LottoPlaceProvider extends ChangeNotifier {
  List<LottoPlaceModel> _lottoPlaceList;

  List<LottoPlaceModel> get lottoPlaceList => _lottoPlaceList;

  LottoPlaceProvider() {

  }

  Future initialize() async {
    await getLottoPlace();
  }

  Future getLottoPlace({String num}) async {
    var req;
    if(num!=null){
      req = LottoPlaceReq(info: num).toJson();
    }
    List<LottoPlaceModel> lottoPlaceList = await HttpService().getLottoPlace(req: req);
    _lottoPlaceList = lottoPlaceList;
    notifyListeners();
  }
}



