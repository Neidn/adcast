// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResult _$ApiResultFromJson(Map<String, dynamic> json) => ApiResult(
      status: json['status'] as String?,
      message: json['message'] as String?,
      totalResults: json['totalResults'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ApiResultToJson(ApiResult instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'totalResults': instance.totalResults,
      'data': instance.data,
    };
