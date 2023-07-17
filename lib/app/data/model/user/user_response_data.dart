import 'package:json_annotation/json_annotation.dart';

part 'user_response_data.g.dart';

@JsonSerializable()
class UserResponseData {
  final String? userid;
  final String? username;
  @JsonKey(name: 'access_token')
  final String? accessToken;
  final String? goods;
  @JsonKey(name: 'expiry_date')
  final String? expiryDate;
  @JsonKey(name: 'r_day')
  final String? rDay;
  final List<Map<String, dynamic>>? customer;
  final List<Map<String, dynamic>>? campaign;

  UserResponseData({
    this.userid,
    this.username,
    this.accessToken,
    this.goods,
    this.expiryDate,
    this.rDay,
    this.customer,
    this.campaign,
  });

  factory UserResponseData.fromJson(Map<String, dynamic> json) =>
      _$UserResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseDataToJson(this);

  bool userResponseDataEmptyCheck() {
    if (userid == "" ||
        userid == null ||
        username == "" ||
        username == null ||
        accessToken == "" ||
        accessToken == null ||
        customer == null ||
        campaign == null) {
      return false;
    } else {
      return true;
    }
  }
}
