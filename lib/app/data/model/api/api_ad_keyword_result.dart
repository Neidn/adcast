import 'package:json_annotation/json_annotation.dart';

part 'api_ad_keyword_result.g.dart';

@JsonSerializable()
class ApiAdKeywordResult {
  final String? status;
  final String? message;
  final String? totalPage;
  final String? page;
  final Map<String, dynamic>? keyword;

  ApiAdKeywordResult({
    this.status,
    this.message,
    this.totalPage,
    this.page,
    this.keyword,
  });

  factory ApiAdKeywordResult.fromJson(Map<String, dynamic> json) =>
      _$ApiAdKeywordResultFromJson(json);

  Map<String, dynamic> toJson() => _$ApiAdKeywordResultToJson(this);

  bool apiResultEmptyCheck() {
    if (status != "OK" && status != "NO") {
      return true;
    }

    if (status == "NO") {
      if (message == "" || message == null) {
        return true;
      }

      return true;
    }

    if (status == "OK") {
      int? totalPageInt = int.tryParse(totalPage!);
      int? pageInt = int.tryParse(page!);

      if (keyword == null || keyword == {}) {
        return true;
      }

      if (totalPageInt == null ||
          totalPageInt < 0 ||
          pageInt == null ||
          pageInt < 0) {
        return true;
      }
    }
    return false;
  }
}
