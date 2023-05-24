// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeywordData _$KeywordDataFromJson(Map<String, dynamic> json) => KeywordData(
      keywordKey: json['keyword_key'] as String?,
      keyword: json['keyword'] as String?,
      status: json['status'] as String?,
      statusReason: json['status_reason'] as String?,
      userLock: json['user_lock'] as String?,
      btype: json['btype'] as String?,
      rcode: json['rcode'] as String?,
      beforeRank: json['before_rank'] as String?,
      currentRank: json['current_rank'] as String?,
      wishRank: json['wish_rank'] as String?,
      bidAmt: json['bid_amt'] as String?,
      maxAmt: json['max_amt'] as String?,
      bidState: json['bid_state'] as String?,
      diagnoseTxt: json['diagnose_txt'] as String?,
    );

Map<String, dynamic> _$KeywordDataToJson(KeywordData instance) =>
    <String, dynamic>{
      'keyword_key': instance.keywordKey,
      'keyword': instance.keyword,
      'status': instance.status,
      'status_reason': instance.statusReason,
      'user_lock': instance.userLock,
      'btype': instance.btype,
      'rcode': instance.rcode,
      'before_rank': instance.beforeRank,
      'current_rank': instance.currentRank,
      'wish_rank': instance.wishRank,
      'bid_amt': instance.bidAmt,
      'max_amt': instance.maxAmt,
      'bid_state': instance.bidState,
      'diagnose_txt': instance.diagnoseTxt,
    };
