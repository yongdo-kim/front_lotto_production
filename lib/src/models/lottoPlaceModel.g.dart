// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottoPlaceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LottoPlaceModel _$LottoPlaceModelFromJson(Map<String, dynamic> json) {
  return LottoPlaceModel(
    ranking: json['ranking'] as String,
    placeName: json['placeName'] as String,
    isAuto: json['isAuto'] as String,
    place: json['place'] as String,
  );
}

Map<String, dynamic> _$LottoPlaceModelToJson(LottoPlaceModel instance) =>
    <String, dynamic>{
      'ranking': instance.ranking,
      'placeName': instance.placeName,
      'isAuto': instance.isAuto,
      'place': instance.place,
    };
