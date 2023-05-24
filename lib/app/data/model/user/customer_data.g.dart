// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerData _$CustomerDataFromJson(Map<String, dynamic> json) => CustomerData(
      status: json['status'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CustomerDataToJson(CustomerData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'id': instance.id,
      'name': instance.name,
    };
