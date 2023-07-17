// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_bid_cycle_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBidCycleData _$UserBidCycleDataFromJson(Map<String, dynamic> json) =>
    UserBidCycleData(
      idx: json['idx'] as String?,
      bidCycle: json['bid_cycle'] as String?,
      keywordId: json['user_id'] as String?,
      keyword: json['keyword'] as String?,
      count: json['count'] as String?,
    );

Map<String, dynamic> _$UserBidCycleDataToJson(UserBidCycleData instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'bid_cycle': instance.bidCycle,
      'user_id': instance.keywordId,
      'keyword': instance.keyword,
      'count': instance.count,
    };
