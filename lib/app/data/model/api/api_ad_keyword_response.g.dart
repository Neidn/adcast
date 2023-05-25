// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_ad_keyword_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiAdKeywordResponse _$ApiAdKeywordResponseFromJson(
        Map<String, dynamic> json) =>
    ApiAdKeywordResponse(
      responseCode: json['response_code'] as String?,
      request: json['request'] as String?,
      response: json['response'] as String?,
      totalData: json['total_data'] as String?,
      userId: json['user_id'] as String?,
      customerId: json['customer_id'] as String?,
      campaignKey: json['campaign_id'] as String?,
      groupKey: json['group_id'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ApiAdKeywordResponseToJson(
        ApiAdKeywordResponse instance) =>
    <String, dynamic>{
      'response_code': instance.responseCode,
      'request': instance.request,
      'response': instance.response,
      'total_data': instance.totalData,
      'user_id': instance.userId,
      'customer_id': instance.customerId,
      'campaign_id': instance.campaignKey,
      'group_id': instance.groupKey,
      'data': instance.data,
    };
