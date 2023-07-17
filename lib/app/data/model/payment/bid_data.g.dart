// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BidData _$BidDataFromJson(Map<String, dynamic> json) => BidData(
      total: json['total'] as String?,
      three: json['three'] as String?,
      five: json['five'] as String?,
      ten: json['ten'] as String?,
      thirty: json['thirty'] as String?,
    );

Map<String, dynamic> _$BidDataToJson(BidData instance) => <String, dynamic>{
      'total': instance.total,
      'three': instance.three,
      'five': instance.five,
      'ten': instance.ten,
      'thirty': instance.thirty,
    };
