import 'package:json_annotation/json_annotation.dart';

part 'customer_data.g.dart';

@JsonSerializable()
class CustomerData {
  final String? status;
  final String? id;
  final String? name;

  CustomerData({
    this.status,
    this.id,
    this.name,
  });

  factory CustomerData.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataToJson(this);

  bool customerDataStatusCheck() => status == 'OK';
}
