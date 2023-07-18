import 'dart:convert';

import 'package:adcast/app/controller/profile/profile_controller.dart';
import 'package:adcast/app/data/model/api/api_response.dart';
import 'package:adcast/app/data/model/payment/bank_data.dart';
import 'package:adcast/app/data/model/payment/bid_data.dart';
import 'package:adcast/app/data/model/payment/good_data.dart';
import 'package:adcast/app/data/model/payment/payment_data.dart';
import 'package:adcast/app/data/repository/payment_data_impl.dart';
import 'package:adcast/app/services/auth_service.dart';
import 'package:adcast/app/storage/db/bank_table.dart';
import 'package:adcast/app/storage/db/goods_table.dart';
import 'package:adcast/app/storage/device/device_token_storage.dart';
import 'package:adcast/app/utils/global_variables.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  static PaymentController get to => Get.find();

  // Database Table
  final BankTable bankTable = BankTable(appBankInfoTable);
  final GoodsTable goodsTable = GoodsTable(appGoodsInfoTable);

  // Goods Data
  final RxList<GoodData> _goodsData = <GoodData>[].obs;

  List<GoodData> get goodsData => _goodsData;

  set goodsData(List<GoodData> value) => _goodsData.value = value;

  // Bank Data
  final Rx<BankData> _bankData = BankData().obs;

  BankData get bankData => _bankData.value;

  set bankData(BankData value) => _bankData.value = value;

  // loading
  final RxBool _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  set isLoading(bool value) => _isLoading.value = value;

  @override
  void onInit() async {
    await setPaymentData();
    await getGoodsAllData();
    await getBankData();

    super.onInit();
  }

  Future<void> setPaymentData() async {
    try {
      final PaymentDataImpl paymentDataImpl = PaymentDataImpl();

      final String deviceToken = await deviceTokenStorage.getDeviceToken();
      if (deviceToken.isEmpty) {
        return;
      }

      ApiResponse apiResponse = await paymentDataImpl.getPaymentGoodsList(
        deviceToken,
      );

      if (apiResponse.apiResponseEmptyCheck() == true) {
        throw Exception(apiResponse.response);
      }

      PaymentData paymentData = PaymentData.fromJson(apiResponse.data);

      if (paymentData.goods == null) {
        throw Exception('Empty Payment Data');
      }

      final List<GoodData> goodDataList = [];

      paymentData.goods!.forEach((key, value) {
        goodDataList.add(GoodData(
          name: key,
          price: value['price'],
          api: value['api'],
          total: value['bid']['total'],
          three: value['bid']['3'],
          five: value['bid']['5'],
          ten: value['bid']['10'],
          thirty: value['bid']['30'],
        ));
      });

      await goodsTable.goodsDataInsert(goodDataList);

      if (paymentData.payment == null) {
        throw Exception('Empty Bank Data');
      }

      final BankData bankData = BankData.fromJson(paymentData.payment!);

      await bankTable.banksDataInsert(bankData);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<GoodData>> getGoodsAllData() async {
    try {
      final List<Map<String, dynamic>> goodsDataList =
          await goodsTable.selectAll();

      if (goodsDataList.isEmpty) {
        throw Exception('Empty Goods Data');
      }

      final List<GoodData> goodDataList = [];

      for (var element in goodsDataList) {
        if (element['name'] == ProfileController.to.userInfoData.goods) {
          ProfileController.to.maxBidData = BidData(
            total: element['total'],
            three: element['three'],
            five: element['five'],
            ten: element['ten'],
            thirty: element['thirty'],
          );
        }

        goodDataList.add(GoodData(
          id: element['id'],
          api: element['api'],
          name: element['name'],
          price: element['price'],
          total: element['total'],
          three: element['three'],
          five: element['five'],
          ten: element['ten'],
          thirty: element['thirty'],
        ));
      }

      goodsData = goodDataList;
      return goodDataList;
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<void> getBankData() async {
    try {
      final List<Map<String, dynamic>> bankDataList =
          await bankTable.select({});

      if (bankDataList.isEmpty) {
        throw Exception('Empty BankData Data');
      }

      bankData = BankData.fromJson(bankDataList.first);
    } catch (e) {
      print(e.toString());
    }
  }
}
