import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '/app/utils/global_variables.dart';

import '/app/data/model/api/api_response.dart';

part 'payment_data.g.dart';

@RestApi(baseUrl: userAuthBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/ad_goods_list.php')
  @Headers(appApiCommonHeaders)
  @FormUrlEncoded()
  Future<ApiResponse> getPaymentGoodsList(
    @Query('devicetoken') String deviceToken,
  );
}

@JsonSerializable()
class PaymentData {
  final Map<String, dynamic>? goods;
  final Map<String, dynamic>? discount;
  final Map<String, dynamic>? payment;

  PaymentData({
    this.goods,
    this.discount,
    this.payment,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) =>
      _$PaymentDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDataToJson(this);
}
