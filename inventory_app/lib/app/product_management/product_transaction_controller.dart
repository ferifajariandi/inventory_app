import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:stokis/app/product_management/product_transaction_page.dart';
import 'package:stokis/shared/database_helper.dart';

class ProductTransactionController extends GetxController {
  Rxn<Stream<DatabaseEvent>> dbStream = Rxn();

  String dateToReadable(String value) {
    List<String> dataRaw = value.split('-');

    return '${dataRaw[2]}/${dataRaw[1]}/${dataRaw[0]}';
  }

  Map<dynamic, dynamic>? dataAfterFilter(Map<dynamic, dynamic>? data,
      {required ProductTransactionType type}) {
    if (data == null) {
      return null;
    } else {
      Map<dynamic, dynamic> dataFinal = {};

      for (var element in data.keys) {
        bool addProduct = false;

        if (type == ProductTransactionType.stockIn) {
          if (data[element]['type'] == 'IN') {
            addProduct = true;
          }
        } else {
          if (data[element]['type'] == 'OUT') {
            addProduct = true;
          }
        }

        if (addProduct) {
          dataFinal[element] = data[element];
        }
      }

      return dataFinal;
    }
  }

  onSetSubscription() {
    dbStream.value = DatabaseHelper.accessDB().ref('transaction').onValue;

    update();
  }

  @override
  void onInit() {
    super.onInit();
    onSetSubscription();
  }
}
