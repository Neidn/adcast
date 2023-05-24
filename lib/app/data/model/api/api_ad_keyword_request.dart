import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '/app/utils/global_variables.dart';

import '/app/data/model/api/api_ad_keyword_response.dart';

part 'api_ad_keyword_request.g.dart';

@RestApi(baseUrl: userAuthBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/ad.php')
  @Headers(appApiCommonHeaders)
  @FormUrlEncoded()
  Future<ApiAdKeywordResponse> getKeyword(
    @Query('devicetoken') String deviceToken,
    @Query('cid') String cid,
    @Query('camid') String camId,
    @Query('grid') String grId,
    @Query('pageSize') String pageSize,
    @Query('page') String page,
  );
}

@JsonSerializable()
class ApiAdKeywordRequest {
  @JsonKey(name: 'devicetoken')
  final String? deviceToken;
  final String? cid;
  @JsonKey(name: 'camid')
  final String? camId;
  @JsonKey(name: 'grid')
  final String? grId;
  final String? pageSize;
  final String? page;

  ApiAdKeywordRequest({
    this.deviceToken,
    this.cid,
    this.camId,
    this.grId,
    this.pageSize,
    this.page,
  });

  factory ApiAdKeywordRequest.fromJson(Map<String, dynamic> json) =>
      _$ApiAdKeywordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ApiAdKeywordRequestToJson(this);
}
