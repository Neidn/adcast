// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_ad_keyword_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiAdKeywordRequest _$ApiAdKeywordRequestFromJson(Map<String, dynamic> json) =>
    ApiAdKeywordRequest(
      deviceToken: json['devicetoken'] as String?,
      cid: json['cid'] as String?,
      camId: json['camid'] as String?,
      grId: json['grid'] as String?,
      pageSize: json['pageSize'] as String?,
      page: json['page'] as String?,
    );

Map<String, dynamic> _$ApiAdKeywordRequestToJson(
        ApiAdKeywordRequest instance) =>
    <String, dynamic>{
      'devicetoken': instance.deviceToken,
      'cid': instance.cid,
      'camid': instance.camId,
      'grid': instance.grId,
      'pageSize': instance.pageSize,
      'page': instance.page,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _RestClient implements RestClient {
  _RestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://www.adcast.co.kr/app';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiAdKeywordResponse> getKeyword(
    String deviceToken,
    String cid,
    String camId,
    String grId,
    String pageSize,
    String page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'devicetoken': deviceToken,
      r'cid': cid,
      r'camid': camId,
      r'grid': grId,
      r'pageSize': pageSize,
      r'page': page,
    };
    final _headers = <String, dynamic>{
      r'User-Agent': 'Adcast/1.0.0 (HostMeca)',
      r'Response-Type': 'application/json',
    };
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiAdKeywordResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/ad.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiAdKeywordResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
