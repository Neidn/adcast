import 'package:json_annotation/json_annotation.dart';

part 'user_info_data.g.dart';

@JsonSerializable()
class UserInfoData {
  final String? userId;
  final String? userName;
  final String? goods;
  final String? expiryDate;
  final String? rDay;

  UserInfoData({
    this.userId,
    this.userName,
    this.goods,
    this.expiryDate,
    this.rDay,
  });

  factory UserInfoData.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoDataToJson(this);

  bool emptyUserInfo() {
    return (userId == null ||
        userId == '' ||
        userName == null ||
        userName == '');
  }
}
