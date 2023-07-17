import 'package:json_annotation/json_annotation.dart';

part 'api_result.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiResult {
  final String? status;
  final String? message;
  final String? totalResults;
  final List<Map<String, dynamic>>? data;

  ApiResult({
    this.status,
    this.message,
    this.totalResults,
    this.data,
  });

  factory ApiResult.fromJson(Map<String, dynamic> json) =>
      _$ApiResultFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResultToJson(this);

  bool apiResultStatusCheck() => status == "OK";

  bool apiResultEmptyCheck() {
    if (status == "" ||
        status == null ||
        totalResults == "" ||
        totalResults == null ||
        data == null) {
      return true;
    }
    return false;
  }

  bool dataLengthCheck() {
    int dataLength = int.tryParse(totalResults!) ?? 0;

    return data!.length == dataLength;
  }
}
