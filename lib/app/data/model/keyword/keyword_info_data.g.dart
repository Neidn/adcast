// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeywordInfoData _$KeywordInfoDataFromJson(Map<String, dynamic> json) =>
    KeywordInfoData(
      userId: json['user_id'] as String?,
      customerId: json['customer_id'] as String?,
      campaignId: json['campaign_id'] as String?,
      groupId: json['group_id'] as String?,
      totalData: json['total_data'] as String?,
      totalPage: json['total_page'] as String?,
      pageSize: json['page_size'] as String?,
      page: json['page'] as String?,
    );

Map<String, dynamic> _$KeywordInfoDataToJson(KeywordInfoData instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'customer_id': instance.customerId,
      'campaign_id': instance.campaignId,
      'group_id': instance.groupId,
      'total_data': instance.totalData,
      'total_page': instance.totalPage,
      'page_size': instance.pageSize,
      'page': instance.page,
    };
