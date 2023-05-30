// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoData _$UserInfoDataFromJson(Map<String, dynamic> json) => UserInfoData(
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      userStatus: json['userStatus'] as String?,
      customerKey: json['customerKey'] as String?,
    );

Map<String, dynamic> _$UserInfoDataToJson(UserInfoData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userStatus': instance.userStatus,
      'customerKey': instance.customerKey,
    };
