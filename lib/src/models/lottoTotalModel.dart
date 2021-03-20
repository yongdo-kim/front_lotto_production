import 'package:json_annotation/json_annotation.dart';

part 'lottoTotalModel.g.dart';

@JsonSerializable(nullable: false)
class LottoTotalModel {
  final String returnValue; //결과값
  final double totSellamnt; //누적상금
  final String drwNoDate; //일시
  final double firstWinamnt; //1등당첨금액
  final int firstPrzwnerCo; //1등총인원
  final int drwtNo1;
  final int drwtNo2;
  final int drwtNo3;
  final int drwtNo4;
  final int drwtNo5;
  final int drwtNo6;
  final int bnusNo;
  final int drwNo;
  final double firstAccumamnt;


  LottoTotalModel(
      {this.returnValue,
      this.totSellamnt,
      this.drwNoDate,
      this.firstWinamnt,
      this.firstPrzwnerCo,
      this.drwtNo1,
      this.drwtNo2,
      this.drwtNo3,
      this.drwtNo4,
      this.drwtNo5,
      this.drwtNo6,
      this.bnusNo,
      this.drwNo,
      this.firstAccumamnt,
      });

  factory LottoTotalModel.fromJson(Map<String, dynamic> json) =>
      _$LottoTotalModelFromJson(json);

  Map<String, dynamic> toJson() => _$LottoTotalModelToJson(this);
}
