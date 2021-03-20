import 'package:json_annotation/json_annotation.dart';

part 'lottoRoundModel.g.dart';

@JsonSerializable(nullable: false)
class LottoRoundModel {
  final String round; //이번회차

  LottoRoundModel({this.round});

  factory LottoRoundModel.fromJson(Map<String, dynamic> json) =>
      _$LottoRoundModelFromJson(json);

  Map<String, dynamic> toJson() => _$LottoRoundModelToJson(this);
}
