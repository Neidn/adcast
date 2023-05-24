import 'package:json_annotation/json_annotation.dart';

part 'campaign_data.g.dart';

@JsonSerializable()
class CampaignData {
  @JsonKey(name: 'campaign_key')
  final String? campaignKey;
  final String? name;
  final String? message;
  @JsonKey(name: 'user_lock')
  final String? userLock;
  final String? status;
  @JsonKey(name: 'status_reason')
  final String? statusReason;

  CampaignData({
    this.campaignKey,
    this.name,
    this.message,
    this.userLock,
    this.status,
    this.statusReason,
  });

  factory CampaignData.fromJson(Map<String, dynamic> json) =>
      _$CampaignDataFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignDataToJson(this);

  bool campaignStatusCheck() => status == "OK";

  bool campaignUserLockCheck() => userLock == "ON";

  bool campaignDataEmptyCheck() {
    if (campaignKey == "" ||
        campaignKey == null ||
        name == "" ||
        name == null ||
        userLock == "" ||
        userLock == null ||
        status == "" ||
        status == null ||
        statusReason == "" ||
        statusReason == null) {
      return true;
    }
    return false;
  }
}
