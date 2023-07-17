// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignData _$CampaignDataFromJson(Map<String, dynamic> json) => CampaignData(
      id: json['id'] as int?,
      customerId: json['customer_id'] as String?,
      campaignKey: json['campaign_key'] as String?,
      campaignName: json['campaign_name'] as String?,
      message: json['message'] as String?,
      userLock: json['user_lock'] as String?,
      status: json['status'] as String?,
      statusReason: json['status_reason'] as String?,
    );

Map<String, dynamic> _$CampaignDataToJson(CampaignData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'campaign_key': instance.campaignKey,
      'campaign_name': instance.campaignName,
      'message': instance.message,
      'user_lock': instance.userLock,
      'status': instance.status,
      'status_reason': instance.statusReason,
    };
