// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseData _$UserResponseDataFromJson(Map<String, dynamic> json) =>
    UserResponseData(
      userid: json['userid'] as String?,
      username: json['username'] as String?,
      accessToken: json['access_token'] as String?,
      goods: json['goods'] as String?,
      expiryDate: json['expiry_date'] as String?,
      rDay: json['r_day'] as String?,
      customer: (json['customer'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      campaign: (json['campaign'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$UserResponseDataToJson(UserResponseData instance) =>
    <String, dynamic>{
      'userid': instance.userid,
      'username': instance.username,
      'access_token': instance.accessToken,
      'goods': instance.goods,
      'expiry_date': instance.expiryDate,
      'r_day': instance.rDay,
      'customer': instance.customer,
      'campaign': instance.campaign,
    };
