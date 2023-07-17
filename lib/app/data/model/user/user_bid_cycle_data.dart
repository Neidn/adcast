import 'package:json_annotation/json_annotation.dart';

part 'user_bid_cycle_data.g.dart';

@JsonSerializable()
class UserBidCycleData {
  final String? idx;
  @JsonKey(name: 'bid_cycle')
  final String? bidCycle;
  @JsonKey(name: 'user_id')
  final String? keywordId;
  final String? keyword;
  final String? count;

  UserBidCycleData({
    this.idx,
    this.bidCycle,
    this.keywordId,
    this.keyword,
    this.count,
  });

  factory UserBidCycleData.fromJson(Map<String, dynamic> json) => _$UserBidCycleDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserBidCycleDataToJson(this);
}
