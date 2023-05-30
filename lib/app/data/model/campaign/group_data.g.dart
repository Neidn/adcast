// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupData _$GroupDataFromJson(Map<String, dynamic> json) => GroupData(
      id: json['id'] as int?,
      campaignKey: json['campaign_key'] as String?,
      groupKey: json['group_key'] as String?,
      groupName: json['group_name'] as String?,
      message: json['message'] as String?,
      userLock: json['user_lock'] as String?,
      status: json['status'] as String?,
      statusReason: json['status_reason'] as String?,
    );

Map<String, dynamic> _$GroupDataToJson(GroupData instance) => <String, dynamic>{
      'id': instance.id,
      'campaign_key': instance.campaignKey,
      'group_key': instance.groupKey,
      'group_name': instance.groupName,
      'message': instance.message,
      'user_lock': instance.userLock,
      'status': instance.status,
      'status_reason': instance.statusReason,
    };
