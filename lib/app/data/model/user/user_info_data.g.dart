// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoData _$UserInfoDataFromJson(Map<String, dynamic> json) => UserInfoData(
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      goods: json['goods'] as String?,
      expiryDate: json['expiryDate'] as String?,
      rDay: json['rDay'] as String?,
    );

Map<String, dynamic> _$UserInfoDataToJson(UserInfoData instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'goods': instance.goods,
      'expiryDate': instance.expiryDate,
      'rDay': instance.rDay,
    };
