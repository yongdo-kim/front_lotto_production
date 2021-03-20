import 'package:json_annotation/json_annotation.dart';

part 'lotto_place_req.g.dart';

@JsonSerializable(nullable: false)
class LottoPlaceReq {

  @JsonKey(name: 'Info')
  final String info;

  LottoPlaceReq({this.info});

  factory LottoPlaceReq.fromJson(Map<String, dynamic> json) =>
      _$LottoPlaceReqFromJson(json);

  Map<String, dynamic> toJson() => _$LottoPlaceReqToJson(this);
}
