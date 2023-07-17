// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuth _$UserAuthFromJson(Map<String, dynamic> json) => UserAuth(
      userId: json['user_id'] as String?,
      userPwd: json['user_pwd'] as String?,
      deviceToken: json['devicetoken'] as String?,
    );

Map<String, dynamic> _$UserAuthToJson(UserAuth instance) => <String, dynamic>{
      'user_id': instance.userId,
      'user_pwd': instance.userPwd,
      'devicetoken': instance.deviceToken,
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
  Future<ApiResponse> getLogin(String deviceToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'devicetoken': deviceToken};
    final _headers = <String, dynamic>{
      r'User-Agent': 'Adcast/1.0.0 (HostMeca)',
      r'Response-Type': 'application/json',
    };
    _headers.removeWhere((k, v) => v == null);
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/login.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ApiResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse> postLogin(
    String userId,
    String userPwd,
    String deviceToken,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'User-Agent': 'Adcast/1.0.0 (HostMeca)',
      r'Response-Type': 'application/json',
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'user_id': userId,
      'user_pwd': userPwd,
      'devicetoken': deviceToken,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/login.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
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

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
