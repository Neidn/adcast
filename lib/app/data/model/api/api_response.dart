import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiResponse {
  @JsonKey(name: 'response_code')
  final String responseCode;
  final String response;
  final String request;
  final Map<String, dynamic> data;

  ApiResponse({
    required this.responseCode,
    required this.response,
    required this.request,
    this.data = const {},
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);

  bool apiResponseCodeCheck() => responseCode == "200";

  bool apiResponseEmptyCheck() {
    if (responseCode == "" ||
        response == "" ||
        request == "" ||
        data == {}) {
      return true;
    }
    return false;
  }

  bool apiResponseLogoutCheck() {
    if (responseCode == "400" && request == "Logout") {
      return true;
    }
    return false;
  }
}
