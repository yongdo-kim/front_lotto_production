import 'package:json_annotation/json_annotation.dart';

part 'lottoPlaceModel.g.dart';

@JsonSerializable(nullable: false)
class LottoPlaceModel {
  final String ranking;
  final String placeName;
  final String isAuto;
  final String place;

  LottoPlaceModel({this.ranking, this.placeName, this.isAuto, this.place});

  factory LottoPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$LottoPlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$LottoPlaceModelToJson(this);
}
