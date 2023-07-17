import 'package:adcast/app/data/model/api/api_response.dart';
import 'package:adcast/app/utils/global_variables.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'api_bid_info.g.dart';

@RestApi(baseUrl: userAuthBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/bid_info.php')
  @Headers(appApiCommonHeaders)
  @FormUrlEncoded()
  Future<ApiResponse> getBidInfo(
    @Query('devicetoken') String deviceToken,
    @Query('user_id') String userId,
  );
}
