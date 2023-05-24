// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_ad_keyword_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiAdKeywordResult _$ApiAdKeywordResultFromJson(Map<String, dynamic> json) =>
    ApiAdKeywordResult(
      status: json['status'] as String?,
      message: json['message'] as String?,
      totalPage: json['totalPage'] as String?,
      page: json['page'] as String?,
      keyword: json['keyword'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ApiAdKeywordResultToJson(ApiAdKeywordResult instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'totalPage': instance.totalPage,
      'page': instance.page,
      'keyword': instance.keyword,
    };
