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

const deviceIdStorageKey = 'deviceId'; // Get_storage Save
const deviceTokenStorageKey = 'deviceToken'; // Get_storage Save
const userDataStorageKey = 'userData';
const customerDataStorageKey = 'customerData';
const campaignListDataStorageKey = 'campaignListData';
const groupListDataStorageKey = 'groupListData';
const keywordListDataStorageKey = 'keywordListData';
const keywordInfoDataStorageKey = 'keywordInfoData';

// SQLite Database Name
const appDatabaseName = 'adcastDatabase.db';
const appDatabaseVersion = 1;
const appCampaignsTable = 'campaigns';
const appGroupsTable = 'groups';
const appKeywordsTable = 'keywords';
const appKeywordInfoTable = 'keywordInfo';
const appUserInfoTable = 'userInfo';
const Map<String, Map<String, String>> appDatabaseTable = {
  appCampaignsTable: {
    'campaign_key': 'TEXT',
    'campaign_name': 'TEXT',
    'message': 'TEXT',
    'user_lock': 'TEXT',
    'status': 'TEXT',
    'status_reason': 'TEXT',
  },
  appGroupsTable: {
    'campaign_key': 'TEXT',
    'group_key': 'TEXT',
    'group_name': 'TEXT',
    'message': 'TEXT',
    'user_lock': 'TEXT',
    'status': 'TEXT',
    'status_reason': 'TEXT',
  },
  appKeywordsTable: {
    'keyword_key': 'TEXT',
    'keyword': 'TEXT',
    'status': 'TEXT',
    'status_reason': 'TEXT',
    'user_lock': 'TEXT',
    'btype': 'TEXT',
    'rcode': 'TEXT',
    'before_rank': 'TEXT',
    'current_rank': 'TEXT',
    'wish_rank': 'TEXT',
    'bid_amt': 'TEXT',
    'max_amt': 'TEXT',
    'bid_state': 'TEXT',
    'diagnose_txt': 'TEXT',
  },
  appKeywordInfoTable: {
    'campaign_key': 'TEXT',
    'group_key': 'TEXT',
    'total_data': 'TEXT',
    'total_page': 'TEXT',
    'current_page': 'TEXT',
    'page_size': 'TEXT',
  },
  appUserInfoTable: {
    'userId': 'TEXT',
    'userName': 'TEXT',
    'userStatus': 'TEXT',
    'customerKey': 'TEXT',
  }
};

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
const defaultPageSize = 10;
const defaultPageSizeString = '10';
const defaultPage = 1;
const defaultPageString = '1';

// Number Format
final numberFormat = NumberFormat("#,###");
