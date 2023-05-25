import 'package:json_annotation/json_annotation.dart';

part 'group_data.g.dart';

@JsonSerializable()
class GroupData {
  final int? id;
  @JsonKey(name: 'campaign_key')
  final String? campaignKey;
  @JsonKey(name: 'group_key')
  final String? groupKey;
  @JsonKey(name: 'group_name')
  final String? groupName;
  final String? message;
  @JsonKey(name: 'user_lock')
  final String? userLock;
  final String? status;
  @JsonKey(name: 'status_reason')
  final String? statusReason;

  GroupData({
    this.id,
    this.campaignKey,
    this.groupKey,
    this.groupName,
    this.message,
    this.userLock,
    this.status,
    this.statusReason,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) =>
      _$GroupDataFromJson(json);

  Map<String, dynamic> toJson() => _$GroupDataToJson(this);
}
