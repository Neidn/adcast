import 'package:json_annotation/json_annotation.dart';

part 'api_ad_keyword_response.g.dart';

@JsonSerializable()
class ApiAdKeywordResponse {
  @JsonKey(name: 'response_code')
  final String? responseCode;
  final String? request;
  final String? response;
  @JsonKey(name: 'total_data')
  final String? totalData;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'customer_id')
  final String? customerId;
  @JsonKey(name: 'campaign_id')
  final String? campaignId;
  @JsonKey(name: 'group_id')
  final String? groupId;
  final Map<String, dynamic>? data;

  ApiAdKeywordResponse({
    this.responseCode,
    this.request,
    this.response,
    this.totalData,
    this.userId,
    this.customerId,
    this.campaignId,
    this.groupId,
    this.data,
  });

  factory ApiAdKeywordResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiAdKeywordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiAdKeywordResponseToJson(this);

  bool apiResponseCodeCheck() => responseCode == "200";

  bool apiResponseEmptyCheck() {
    if (responseCode == "" ||
        responseCode == null ||
        response == "" ||
        response == null ||
        request == "" ||
        request == null ||
        totalData == "" ||
        totalData == null ||
        data == {} ||
        data == null) {
      return true;
    }
    return false;
  }
}
