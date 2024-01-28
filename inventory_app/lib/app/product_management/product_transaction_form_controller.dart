import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stokis/app/product_management/models/product_stock_transaction_model.dart';
import 'package:stokis/app/product_management/product_management_main_page.dart';
import 'package:stokis/app/product_management/product_transaction_page.dart';
import 'package:stokis/shared/database_helper.dart';
import 'package:stokis/shared/global_data/user_logged.dart';
import 'package:stokis/shared/show_snackbar.dart';
import 'package:stokis/shared/widgets/yes_or_no_dialog.dart';

class ProductTransactionFormController extends GetxController {
  RxList<ProductStockTransactionModel> dataUpdate = RxList();

  onChangeField(int i, String value, {required ProductTransactionType type}) {
    if (value.isEmpty) {
      dataUpdate[i].validation =
          'Mohon mengisi jumlah ${type == ProductTransactionType.stockIn ? 'barang masuk' : 'barang keluar'}';
    } else {
      if (type == ProductTransactionType.stockOut) {
        if (int.parse(dataUpdate[i].data['stock']) < int.parse(value)) {
          dataUpdate[i].validation = 'Tidak boleh melebihi stok';
        } else {
          dataUpdate[i].validation = null;
        }
      } else {
        dataUpdate[i].validation = null;
      }
    }
    update();
  }

  onRemoveData(int index) {
    dataUpdate.removeAt(index);
    update();
  }

  onAddProduct(BuildContext context) async {
    Map<String, dynamic>? result =
        await Get.to(() => const ProductManagementMainPage(
              type: ProductManagementViewType.pick,
            ));

    if (result != null) {
      bool isDuplicate = false;

      for (var i = 0; i < dataUpdate.length; i++) {
        if (result['sku'] == dataUpdate[i].data['sku']) {
          isDuplicate = true;
        }
      }

      if (isDuplicate) {
        if (context.mounted) {
          showSnackbar(context,
              title: 'Tambah Barang',
              message: 'Anda telah menambahkan produk ${result['name']}',
              customColor: Colors.orange);
        }
      } else {
        dataUpdate.add(ProductStockTransactionModel(
            data: result, qtyController: TextEditingController(text: '1')));
        update();
      }
    }
  }

  onSaveTransaction(BuildContext context,
      {required ProductTransactionType type}) async {
    List<bool> listDataValidation = [];

    for (var i = 0; i < dataUpdate.length; i++) {
      if (dataUpdate[i].qtyController.text.isEmpty) {
        dataUpdate[i].validation =
            'Mohon mengisi jumlah ${type == ProductTransactionType.stockIn ? 'barang masuk' : 'barang keluar'}';
        listDataValidation.add(false);
      } else {
        if (type == ProductTransactionType.stockOut) {
          if (int.parse(dataUpdate[i].data['stock']) <
              int.parse(dataUpdate[i].qtyController.text)) {
            dataUpdate[i].validation = 'Tidak boleh melebihi stok';
            listDataValidation.add(false);
          } else {
            listDataValidation.add(true);
          }
        } else {
          listDataValidation.add(true);
        }
      }
    }

    update();

    if (listDataValidation.contains(false)) {
      showSnackbar(context,
          title: type == ProductTransactionType.stockIn
              ? 'Barang Masuk'
              : 'Barang Keluar',
          customColor: Colors.orange,
          message: "Mohon cek kembali isian Anda");
    } else {
      yesOrNoDialog(context,
              title: 'Simpan Data',
              desc: 'Apakah Anda yakin untuk menyimpan data?')
          .then((value) async {
        if (value) {
          EasyLoading.show();
          for (var i = 0; i < dataUpdate.length; i++) {
            DatabaseReference ref = DatabaseHelper.accessDB()
                .ref('products/${dataUpdate[i].data['sku']}');

            final snapshot = await ref.get();

            if (snapshot.exists) {
              Map<dynamic, dynamic> dataProduct =
                  snapshot.value! as Map<dynamic, dynamic>;

              dataProduct['stock'] = type == ProductTransactionType.stockIn
                  ? (int.parse(dataProduct['stock'].toString()) +
                          int.parse(dataUpdate[i].qtyController.text))
                      .toString()
                  : (int.parse(dataProduct['stock'].toString()) -
                          int.parse(dataUpdate[i].qtyController.text))
                      .toString();

              ref.set(dataProduct);
            }
          }

          DatabaseReference refTransaction = DatabaseHelper.accessDB().ref(
              'transaction/${UserLogged.getUser()['username']}_${DateTime.now().microsecondsSinceEpoch}');
          refTransaction.set({
            'created_at':
                DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
            'created_by': UserLogged.getUser()['username'],
            'creator_name': UserLogged.getUser()['nama'],
            'type': type == ProductTransactionType.stockIn ? 'IN' : 'OUT',
            'data': List.generate(dataUpdate.length, (index) {
              return {
                'sku': dataUpdate[index].data['sku'],
                'name': dataUpdate[index].data['name'],
                'update_stock': dataUpdate[index].qtyController.text
              };
            })
          });
          EasyLoading.dismiss();
          Get.back();
          if (context.mounted) {
            showSnackbar(context,
                title: type == ProductTransactionType.stockIn
                    ? 'Barang Masuk'
                    : 'Barang Keluar',
                customColor: Colors.green,
                message:
                    "Berhasil menambahkan ${type == ProductTransactionType.stockIn ? 'Barang Masuk' : 'Barang Keluar'}");
          }
        }
      });
    }
  }
}
