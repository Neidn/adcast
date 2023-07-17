import 'package:json_annotation/json_annotation.dart';

part 'user_api_data.g.dart';

@JsonSerializable()
class UserApiData {
  final int? id;
  @JsonKey(name: 'customer_id')
  final String? customerId;
  @JsonKey(name: 'customer_name')
  final String? customerName;
  final String? status;
  final String? bizmoney;

  UserApiData({
    this.id,
    this.customerId,
    this.customerName,
    this.status,
    this.bizmoney,
  });

  factory UserApiData.fromJson(Map<String, dynamic> json) =>
      _$UserApiDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiDataToJson(this);
}
