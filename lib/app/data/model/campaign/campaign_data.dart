import 'package:json_annotation/json_annotation.dart';

part 'campaign_data.g.dart';

@JsonSerializable()
class CampaignData {
  final int? id;
  @JsonKey(name: 'customer_id')
  final String? customerId;
  @JsonKey(name: 'campaign_key')
  final String? campaignKey;
  @JsonKey(name: 'campaign_name')
  final String? campaignName;
  final String? message;
  @JsonKey(name: 'user_lock')
  final String? userLock;
  final String? status;
  @JsonKey(name: 'status_reason')
  final String? statusReason;

  CampaignData({
    this.id,
    this.customerId,
    this.campaignKey,
    this.campaignName,
    this.message,
    this.userLock,
    this.status,
    this.statusReason,
  });

  factory CampaignData.fromJson(Map<String, dynamic> json) =>
      _$CampaignDataFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignDataToJson(this);
}
