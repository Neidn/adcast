import 'package:json_annotation/json_annotation.dart';

part 'keyword_info_data.g.dart';

@JsonSerializable()
class KeywordInfoData {
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'customer_id')
  final String? customerId;
  @JsonKey(name: 'campaign_id')
  final String? campaignId;
  @JsonKey(name: 'group_id')
  final String? groupId;
  @JsonKey(name: 'total_data')
  String? totalData;
  @JsonKey(name: 'total_page')
  String? totalPage;
  @JsonKey(name: 'page_size')
  String? pageSize;
  String? page;

  KeywordInfoData({
    this.userId,
    this.customerId,
    this.campaignId,
    this.groupId,
    this.totalData,
    this.totalPage,
    this.pageSize,
    this.page,
  });

  factory KeywordInfoData.fromJson(Map<String, dynamic> json) =>
      _$KeywordInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordInfoDataToJson(this);

  bool apiResultEmptyCheck() {
    if (userId == null ||
        userId == "" ||
        customerId == null ||
        customerId == "" ||
        campaignId == null ||
        campaignId == "" ||
        groupId == null ||
        groupId == "" ||
        totalData == null ||
        totalPage == null ||
        pageSize == null ||
        page == null) {
      return true;
    }

    int? totalDataInt = int.tryParse(totalData!);
    int? totalPageInt = int.tryParse(totalPage!);
    int? pageSizeInt = int.tryParse(pageSize!);
    int? pageInt = int.tryParse(page!);

    if (totalDataInt == null ||
        totalDataInt < 0 ||
        totalPageInt == null ||
        totalPageInt < 0 ||
        pageSizeInt == null ||
        pageSizeInt < 0 ||
        pageInt == null ||
        pageInt < 0) {
      return true;
    }

    return false;
  }
}
