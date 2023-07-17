// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiData _$UserApiDataFromJson(Map<String, dynamic> json) => UserApiData(
      id: json['id'] as int?,
      customerId: json['customer_id'] as String?,
      customerName: json['customer_name'] as String?,
      status: json['status'] as String?,
      bizmoney: json['bizmoney'] as String?,
    );

Map<String, dynamic> _$UserApiDataToJson(UserApiData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'customer_name': instance.customerName,
      'status': instance.status,
      'bizmoney': instance.bizmoney,
    };
