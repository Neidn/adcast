import 'package:json_annotation/json_annotation.dart';

part 'keyword_list_data.g.dart';

@JsonSerializable()
class KeywordListData {
  final String? totalResults;
  final Map<String, dynamic>? data;

  KeywordListData({
    this.totalResults,
    this.data,
  });

  factory KeywordListData.fromJson(Map<String, dynamic> json) =>
      _$KeywordListDataFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordListDataToJson(this);

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
