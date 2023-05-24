import 'package:get_storage/get_storage.dart';

import '/app/data/model/user/customer_data.dart';

import '/app/utils/global_variables.dart';

class CustomerDataStorage {
  final _box = GetStorage(appStorage);

  // Customer Data
  CustomerData get customerData {
    try {
      return CustomerData.fromJson(_box.read(customerDataStorageKey) ?? {});
    } catch (e) {
      resetCustomerData();
      return CustomerData();
    }
  }

  String get customerId => customerDataStorage.customerData.id ?? '';

  set customerData(CustomerData value) =>
      _box.write(customerDataStorageKey, value.toJson());

  Future<void> resetCustomerData() async {
    try {
      await _box.remove(customerDataStorageKey);
    } catch (e) {
      rethrow;
    }
  }

  bool emptyCustomerDataCheck() {
    try {
      if (customerDataStorage.customerData.status == '' ||
          customerDataStorage.customerData.status == null ||
          customerDataStorage.customerData.status?.isEmpty == true ||
          customerDataStorage.customerData.id == '' ||
          customerDataStorage.customerData.id == null ||
          customerDataStorage.customerData.id?.isEmpty == true ||
          customerDataStorage.customerData.name == '' ||
          customerDataStorage.customerData.name == null ||
          customerDataStorage.customerData.name?.isEmpty == true) {
        return true;
      }
    } catch (e) {
      resetCustomerData();
      return true;
    }
    return false;
  }
}

final customerDataStorage = CustomerDataStorage();
