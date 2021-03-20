import 'package:yd_lotto_provider/src/constant/address.dart';
import 'package:yd_lotto_provider/src/models/lottoPlaceModel.dart';
import 'package:yd_lotto_provider/src/models/lottoTotalModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:yd_lotto_provider/src/models/lottoRoundModel.dart';

class HttpService {
  HttpService() {}

  Future getLottoPlace({dynamic req}) async {
    try {
      if (req == null) {
        final LottoRoundModel lottoRoundModel = await getThisRound();
        req = lottoRoundModel.toJson();
      }

      String url = ConstAddress.LOTTO_PLACE;
      final response = await http.post(url, body: req); //req==null => 최신자료.
      if (response.statusCode == 200 || response.statusCode == 201) {
        //nestjs == 201
        final responseData = json.decode(response.body);
        if (responseData['resultCode'] == "1") {
          var lottoPlace = (responseData['data'] as List)
              .map((place) => LottoPlaceModel.fromJson(place))
              .toList();
          if (lottoPlace.length > 0) {
            return lottoPlace;
          } else {
            return null;
          }
        } else {
          throw ("resultCode is not 1");
        }
      } else {
        throw ("statusCode is not 200");
      }
    } catch (e) {
      print(e);
    }
  }

  Future getThisRound({dynamic req}) async {
    try {
      String url = ConstAddress.LOTTO_THIS_ROUND;
      final http.Response response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final LottoRoundModel lottoRound =
            LottoRoundModel.fromJson(responseData[0]);
        return lottoRound;
      } else {
        throw ("statusCode is not 200");
      }
    } catch (e) {
      print(e);
    }
  }

  Future getLottoTotalValue({dynamic req}) async {
    try {
      if(req==null){
        final LottoRoundModel currentRound =  await getThisRound();
        req = currentRound.round;
        print(req);
      }

      String url = ConstAddress.LOTTO_TOTAL_VALUE + req;
      final http.Response response = await http.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        final LottoTotalModel lottoTotalValue =
            LottoTotalModel.fromJson(responseData);

        return lottoTotalValue;
      } else {
        throw ("statusCode is not 200");
      }
    } catch (e) {
      print(e);
    }
  }
}
