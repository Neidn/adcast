// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'good_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodData _$GoodDataFromJson(Map<String, dynamic> json) => GoodData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      api: json['api'] as String?,
      price: json['price'] as String?,
      bid: json['bid'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GoodDataToJson(GoodData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'api': instance.api,
      'price': instance.price,
      'bid': instance.bid,
    };
