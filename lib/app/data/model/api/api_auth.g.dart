// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiAuth _$ApiAuthFromJson(Map<String, dynamic> json) => ApiAuth(
      deviceToken: json['session'] as String?,
    );

Map<String, dynamic> _$ApiAuthToJson(ApiAuth instance) => <String, dynamic>{
      'session': instance.deviceToken,
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
  Future<ApiResponse> getSessionCheck(String deviceToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'User-Agent': 'Adcast/1.0.0 (HostMeca)',
      r'Response-Type': 'application/json',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {'devicetoken': deviceToken};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/session_check.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse.fromJson(_result.data!);
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