// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword_info_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeywordInfoData _$KeywordInfoDataFromJson(Map<String, dynamic> json) =>
    KeywordInfoData(
      id: json['id'] as int?,
      campaignKey: json['campaign_key'] as String?,
      groupKey: json['group_key'] as String?,
      totalData: json['total_data'] as String?,
      totalPage: json['total_page'] as String?,
      pageSize: json['page_size'] as String?,
      currentPage: json['current_page'] as String?,
    );

Map<String, dynamic> _$KeywordInfoDataToJson(KeywordInfoData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaign_key': instance.campaignKey,
      'group_key': instance.groupKey,
      'total_data': instance.totalData,
      'total_page': instance.totalPage,
      'page_size': instance.pageSize,
      'current_page': instance.currentPage,
    };
