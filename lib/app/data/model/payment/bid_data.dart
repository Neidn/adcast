import 'package:json_annotation/json_annotation.dart';

part 'bid_data.g.dart';

@JsonSerializable()
class BidData {
  final String? total;
  final String? three;
  final String? five;
  final String? ten;
  final String? thirty;

  BidData({
    this.total,
    this.three,
    this.five,
    this.ten,
    this.thirty,
  });

  factory BidData.fromJson(Map<String, dynamic> json) => _$BidDataFromJson(json);

  Map<String, dynamic> toJson() => _$BidDataToJson(this);
}
