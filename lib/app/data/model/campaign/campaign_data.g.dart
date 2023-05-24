// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignData _$CampaignDataFromJson(Map<String, dynamic> json) => CampaignData(
      campaignKey: json['campaign_key'] as String?,
      name: json['name'] as String?,
      message: json['message'] as String?,
      userLock: json['user_lock'] as String?,
      status: json['status'] as String?,
      statusReason: json['status_reason'] as String?,
    );

Map<String, dynamic> _$CampaignDataToJson(CampaignData instance) =>
    <String, dynamic>{
      'campaign_key': instance.campaignKey,
      'name': instance.name,
      'message': instance.message,
      'user_lock': instance.userLock,
      'status': instance.status,
      'status_reason': instance.statusReason,
    };
