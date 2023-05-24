// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      responseCode: json['response_code'] as String,
      response: json['response'] as String,
      request: json['request'] as String,
      data: json['data'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'response_code': instance.responseCode,
      'response': instance.response,
      'request': instance.request,
      'data': instance.data,
    };
