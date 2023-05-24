import 'package:json_annotation/json_annotation.dart';

part 'group_data.g.dart';

@JsonSerializable()
class GroupData {
  @JsonKey(name: 'campaign_key')
  final String? campaignKey;
  @JsonKey(name: 'group_key')
  final String? groupKey;
  final String? name;
  final String? message;
  @JsonKey(name: 'user_lock')
  final String? userLock;
  final String? status;
  @JsonKey(name: 'status_reason')
  final String? statusReason;

  GroupData({
    this.campaignKey,
    this.groupKey,
    this.name,
    this.message,
    this.userLock,
    this.status,
    this.statusReason,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) =>
      _$GroupDataFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataToJson(this);

  bool groupStatusCheck() => status == "OK";

  bool groupUserLockCheck() => userLock == "ON";

  bool emptyCampaignKeyCheck() => campaignKey == "" || campaignKey == null;

  bool emptyGroupKeyCheck() => groupKey == "" || groupKey == null;

  bool groupDataEmptyCheck() {
    if (campaignKey == "" ||
        campaignKey == null ||
        groupKey == "" ||
        groupKey == null ||
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
