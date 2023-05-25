import 'package:json_annotation/json_annotation.dart';

part 'keyword_info_data.g.dart';

@JsonSerializable()
class KeywordInfoData {
  final int? id;
  @JsonKey(name: 'campaign_key')
  final String? campaignKey;
  @JsonKey(name: 'group_key')
  final String? groupKey;
  @JsonKey(name: 'total_data')
  String? totalData;
  @JsonKey(name: 'total_page')
  String? totalPage;
  @JsonKey(name: 'page_size')
  String? pageSize;
  @JsonKey(name: 'current_page')
  String? currentPage;

  KeywordInfoData({
    this.id,
    this.campaignKey,
    this.groupKey,
    this.totalData,
    this.totalPage,
    this.pageSize,
    this.currentPage,
  });

  factory KeywordInfoData.fromJson(Map<String, dynamic> json) =>
      _$KeywordInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordInfoDataToJson(this);

  bool emptyKeywordInfo() {
    return (campaignKey == null ||
        campaignKey == '' ||
        groupKey == null ||
        groupKey == '' ||
        totalData == null ||
        totalData == '' ||
        totalPage == null ||
        totalPage == '' ||
        pageSize == null ||
        pageSize == '' ||
        currentPage == null ||
        currentPage == '');
  }
}
