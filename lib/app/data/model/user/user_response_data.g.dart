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
      customer: json['customer'] as Map<String, dynamic>?,
      campaign: json['campaign'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$UserResponseDataToJson(UserResponseData instance) =>
    <String, dynamic>{
      'userid': instance.userid,
      'username': instance.username,
      'access_token': instance.accessToken,
      'customer': instance.customer,
      'campaign': instance.campaign,
    };
