// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottoTotalModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LottoTotalModel _$LottoTotalModelFromJson(Map<String, dynamic> json) {
  return LottoTotalModel(
    returnValue: json['returnValue'] as String,
    totSellamnt: (json['totSellamnt'] as num).toDouble(),
    drwNoDate: json['drwNoDate'] as String,
    firstWinamnt: (json['firstWinamnt'] as num).toDouble(),
    firstPrzwnerCo: json['firstPrzwnerCo'] as int,
    drwtNo1: json['drwtNo1'] as int,
    drwtNo2: json['drwtNo2'] as int,
    drwtNo3: json['drwtNo3'] as int,
    drwtNo4: json['drwtNo4'] as int,
    drwtNo5: json['drwtNo5'] as int,
    drwtNo6: json['drwtNo6'] as int,
    bnusNo: json['bnusNo'] as int,
    drwNo: json['drwNo'] as int,
    firstAccumamnt: (json['firstAccumamnt'] as num).toDouble(),
  );
}

Map<String, dynamic> _$LottoTotalModelToJson(LottoTotalModel instance) =>
    <String, dynamic>{
      'returnValue': instance.returnValue,
      'totSellamnt': instance.totSellamnt,
      'drwNoDate': instance.drwNoDate,
      'firstWinamnt': instance.firstWinamnt,
      'firstPrzwnerCo': instance.firstPrzwnerCo,
      'drwtNo1': instance.drwtNo1,
      'drwtNo2': instance.drwtNo2,
      'drwtNo3': instance.drwtNo3,
      'drwtNo4': instance.drwtNo4,
      'drwtNo5': instance.drwtNo5,
      'drwtNo6': instance.drwtNo6,
      'bnusNo': instance.bnusNo,
      'drwNo': instance.drwNo,
      'firstAccumamnt': instance.firstAccumamnt,
    };
