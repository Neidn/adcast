import 'package:json_annotation/json_annotation.dart';

part 'good_data.g.dart';

@JsonSerializable()
class GoodData {
  final int? id;
  final String? name;
  final String? api;
  final String? price;
  final Map<String, dynamic>? bid;

  GoodData({
    this.id,
    this.name,
    this.api,
    this.price,
    this.bid,
  });

  factory GoodData.fromJson(Map<String, dynamic> json) =>
      _$GoodDataFromJson(json);

  Map<String, dynamic> toJson() => _$GoodDataToJson(this);
}
