import 'package:json_annotation/json_annotation.dart';

part 'good_data.g.dart';

@JsonSerializable()
class GoodData {
  final int? id;
  final String? name;
  final String? api;
  final String? price;
  final String? total;
  final String? three;
  final String? five;
  final String? ten;
  final String? thirty;

  GoodData({
    this.id,
    this.name,
    this.api,
    this.price,
    this.total,
    this.three,
    this.five,
    this.ten,
    this.thirty,
  });

  factory GoodData.fromJson(Map<String, dynamic> json) =>
      _$GoodDataFromJson(json);

  Map<String, dynamic> toJson() => _$GoodDataToJson(this);
}
