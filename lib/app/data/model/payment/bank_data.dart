import 'package:json_annotation/json_annotation.dart';

part 'bank_data.g.dart';

@JsonSerializable()
class BankData {
  @JsonKey(name: 'bank_name')
  final String? bankName;
  @JsonKey(name: 'bank_num')
  final String? bankNum;
  @JsonKey(name: 'bank_owner')
  final String? bankOwner;

  BankData({
    this.bankName,
    this.bankNum,
    this.bankOwner,
  });

  factory BankData.fromJson(Map<String, dynamic> json) =>
      _$BankDataFromJson(json);

  Map<String, dynamic> toJson() => _$BankDataToJson(this);
}
