import 'package:json_annotation/json_annotation.dart';

part 'keyword_list_info_data.g.dart';

@JsonSerializable()
class KeywordListInfoData {
  final String? totalResults;
  final Map<String, dynamic>? data;

  KeywordListInfoData({
    this.totalResults,
    this.data,
  });

  factory KeywordListInfoData.fromJson(Map<String, dynamic> json) =>
      _$KeywordListInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordListInfoDataToJson(this);

  bool emptyKeywordListDataCheck() {
    if (totalResults == null ||
        totalResults == "" ||
        data == null ||
        data == {}) {
      return true;
    }

    int? totalResultsInt = int.tryParse(totalResults!);

    if (totalResultsInt == null || totalResultsInt < 0) {
      return true;
    }

    return totalResultsInt != data!.length;
  }
}
