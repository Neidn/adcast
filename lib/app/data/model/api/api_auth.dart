import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '/app/utils/global_variables.dart';

import '/app/data/model/api/api_response.dart';

part 'api_auth.g.dart';

@RestApi(baseUrl: userAuthBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/session_check.php')
  @Headers(appApiCommonHeaders)
  @FormUrlEncoded()
  Future<ApiResponse> getSessionCheck(
    @Field('devicetoken') String deviceToken,
  );
}

@JsonSerializable()
class ApiAuth {
  @JsonKey(name: 'session')
  final String? deviceToken;

  ApiAuth({
    this.deviceToken,
  });

  factory ApiAuth.fromJson(Map<String, dynamic> json) =>
      _$ApiAuthFromJson(json);

  Map<String, dynamic> toJson() => _$ApiAuthToJson(this);

  bool get isEmpty =>
      (deviceToken == null || deviceToken!.isEmpty || deviceToken == '');

  bool logoutCheck(String request) {
    if (request == "Logout") {
      return true;
    }
    return false;
  }
}
