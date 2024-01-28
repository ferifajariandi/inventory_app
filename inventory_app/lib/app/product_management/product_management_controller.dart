import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokis/shared/database_helper.dart';
import 'package:stokis/shared/show_snackbar.dart';
import 'package:stokis/shared/widgets/yes_or_no_dialog.dart';

class ProductManagementController extends GetxController {
  Rxn<Stream<DatabaseEvent>> dbStream = Rxn();

  Rx<String> searchValue = Rx('');
  TextEditingController searchController = TextEditingController();

  onSearchChanged(String value) {
    searchValue.value = value;
    update();
  }

  Map<dynamic, dynamic>? dataAfterFilter(Map<dynamic, dynamic>? data) {
    if (data == null) {
      return null;
    } else {
      Map<dynamic, dynamic> dataFinal = {};

      for (var element in data.keys) {
        bool addProduct = false;

        if (element.toString().contains(searchValue.value)) {
          addProduct = true;
        }

        if (data[element]['name'].toString().contains(searchValue.value)) {
          addProduct = true;
        }

        if (addProduct) {
          dataFinal[element] = data[element];
        }
      }

      return dataFinal;
    }
  }

  deleteProduct(BuildContext context, String keyData) async {
    yesOrNoDialog(context,
            title: 'Hapus Produk',
            desc: 'Apakah Anda yakin untuk menghapus produk ini?')
        .then((value) async {
      if (value) {
        await DatabaseHelper.accessDB().ref('products').child(keyData).remove();
        if (context.mounted) {
          showSnackbar(context,
              title: 'Hapus Produk',
              customColor: Colors.green,
              message: 'Berhasil hapus produk');
        }
      }
    });
  }

  onSetSubscription() {
    dbStream.value = DatabaseHelper.accessDB().ref('products').onValue;

    update();
  }

  @override
  void onInit() {
    super.onInit();
    onSetSubscription();
  }
}
