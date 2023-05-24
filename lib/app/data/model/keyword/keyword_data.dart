import 'package:json_annotation/json_annotation.dart';

part 'keyword_data.g.dart';

@JsonSerializable()
class KeywordData {
  @JsonKey(name: 'keyword_key')
  final String? keywordKey;
  final String? keyword;
  final String? status;
  @JsonKey(name: 'status_reason')
  final String? statusReason;
  @JsonKey(name: 'user_lock')
  final String? userLock;
  final String? btype;
  final String? rcode;
  @JsonKey(name: 'before_rank')
  final String? beforeRank;
  @JsonKey(name: 'current_rank')
  final String? currentRank;
  @JsonKey(name: 'wish_rank')
  final String? wishRank;
  @JsonKey(name: 'bid_amt')
  final String? bidAmt;
  @JsonKey(name: 'max_amt')
  final String? maxAmt;
  @JsonKey(name: 'bid_state')
  final String? bidState;
  @JsonKey(name: 'diagnose_txt')
  final String? diagnoseTxt;


  KeywordData({
    this.keywordKey,
    this.keyword,
    this.status,
    this.statusReason,
    this.userLock,
    this.btype,
    this.rcode,
    this.beforeRank,
    this.currentRank,
    this.wishRank,
    this.bidAmt,
    this.maxAmt,
    this.bidState,
    this.diagnoseTxt,
  });

  factory KeywordData.fromJson(Map<String, dynamic> json) =>
      _$KeywordDataFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordDataToJson(this);

  bool keywordDataUserLockCheck() => userLock == 'ON';

  bool keywordDataEmptyCheck() {
    if (userLock != "ON" && userLock != "OFF") {
      return true;
    }

    if (keywordKey == null ||
        keywordKey == "" ||
        keyword == null ||
        keyword == "" ||
        status == null ||
        status == "" ||
        statusReason == null) {
      return true;
    }
    return false;
  }
}
