import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

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

// Secure Storage Options
AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

IOSOptions getIOSOptions() => const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    );

// Storage Key
const deviceIdStorageKey = 'deviceId'; // storage Save
const deviceTokenStorageKey = 'deviceToken'; // storage Save
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
const appUserApiTable = 'userApi';
const appBankInfoTable = 'bankInfo';
const appGoodsInfoTable = 'goodsList';
const appBidInfoTable = 'bidInfo';

// Table SQL
const Map<String, Map<String, String>> appDatabaseTable = {
  appCampaignsTable: {
    'customer_id': 'TEXT',
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
    'goods': 'TEXT',
    'expiryDate': 'TEXT',
    'rDay': 'TEXT',
  },
  appUserApiTable: {
    'status': 'TEXT',
    'customer_id': 'TEXT',
    'customer_name': 'TEXT',
    'bizmoney': 'TEXT',
  },
  appBankInfoTable: {
    'bank_name': 'TEXT',
    'bank_num': 'TEXT',
    'bank_owner': 'TEXT',
  },
  appGoodsInfoTable: {
    'name': 'TEXT',
    'api': 'TEXT',
    'price': 'TEXT',
    'bid': 'JSON',
  },
  appBidInfoTable: {
    'total': 'TEXT',
    'three': 'TEXT',
    'five': 'TEXT',
    'ten': 'TEXT',
    'thirty': 'TEXT',
  },
};

// Table Indexes SQL
const Map<String, List<String>> appDatabaseIndexes = {
  appCampaignsTable: [
    "id",
    "customer_id",
    "campaign_key",
  ],
  appGroupsTable: [
    "id",
    "campaign_key",
    "group_key",
  ],
  appKeywordsTable: [
    "id",
    "keyword_key",
    "user_lock",
  ],
  appKeywordInfoTable: [
    "id",
  ],
  appUserInfoTable: [
    "id",
  ],
  appUserApiTable: [
    "id",
    "customer_id",
  ],
  appBankInfoTable: [
    "id",
    "bank_name",
    "bank_num",
    "bank_owner",
  ],
  appBidInfoTable: [
    "id",
  ],
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
