import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:intl/intl.dart';

final dio = Dio(
  BaseOptions(
    responseType: ResponseType.json,
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
    receiveDataWhenStatusError: true,
  ),
)..interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 200,
    ),
  );

// Storage Key
const appStorage = 'appStorage';

const deviceIdStorageKey = 'deviceId';
const deviceTokenStorageKey = 'deviceToken';
const userDataStorageKey = 'userData';
const customerDataStorageKey = 'customerData';
const campaignListDataStorageKey = 'campaignListData';
const groupListDataStorageKey = 'groupListData';
const keywordListDataStorageKey = 'keywordListData';
const keywordInfoDataStorageKey = 'keywordInfoData';

// App API Base Url
const String userAuthBaseUrl = 'https://www.adcast.co.kr/app';

// App Common Variables
const String companyName = "HostMeca";
const String appName = 'Adcast';
const String appVersion = '1.0.0';

// App API Common Headers
const appApiCommonHeaders = {
  "User-Agent": "$appName/$appVersion ($companyName)",
  "Response-Type": "application/json",
};

// App API Common Parameters
const defaultPageSize = "10";
const defaultPage = "1";

// Number Format
final numberFormat = NumberFormat("#,###");
