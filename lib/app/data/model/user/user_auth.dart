import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '/app/utils/global_variables.dart';

import '/app/data/model/api/api_response.dart';

part 'user_auth.g.dart';

@RestApi(baseUrl: userAuthBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/login.php')
  @Headers(appApiCommonHeaders)
  @FormUrlEncoded()
  Future<ApiResponse> getLogin(
    @Query('devicetoken') String deviceToken,
  );

  @POST('/login.php')
  @Headers(appApiCommonHeaders)
  @FormUrlEncoded()
  Future<ApiResponse> postLogin(
    @Field('user_id') String userId,
    @Field('user_pwd') String userPwd,
    @Field('devicetoken') String deviceToken,
  );
}

@JsonSerializable()
class UserAuth {
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(name: 'user_pwd')
  final String? userPwd;
  @JsonKey(name: 'devicetoken')
  final String? deviceToken;

  UserAuth({
    this.userId,
    this.userPwd,
    this.deviceToken,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) =>
      _$UserAuthFromJson(json);

  Map<String, dynamic> toJson() => _$UserAuthToJson(this);
}
