import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stokis/shared/database_helper.dart';
import 'package:stokis/shared/show_snackbar.dart';

class ProductManagementFormController extends GetxController {
  TextEditingController nameController = TextEditingController();
  Rxn<String> nameValidation = Rxn();
  TextEditingController stockController = TextEditingController();
  Rxn<String> stockValidation = Rxn();
  TextEditingController skuController = TextEditingController();
  Rxn<String> skuValidation = Rxn();
  TextEditingController ukuranController = TextEditingController();
  Rxn<String> ukuranValidation = Rxn();
  TextEditingController priceController = TextEditingController();
  Rxn<String> priceValidation = Rxn();

  onInitData({String? dataKey, Map<dynamic, dynamic>? data}) {
    if (dataKey != null) {
      skuController.text = dataKey;
      stockController.text = data!['stock'];
      nameController.text = data['name'];
      update();
    }
  }

  onChangeName(String value) {
    if (value.isEmpty) {
      nameValidation.value = 'Mohon mengisi nama produk';
    } else {
      nameValidation.value = null;
    }
    update();
  }

  onChangeStock(String value) {
    if (value.isEmpty) {
      stockValidation.value = 'Mohon mengisi stok produk';
    } else {
      stockValidation.value = null;
    }
    update();
  }

  onChangeUkuran(String value) {
    if (value.isEmpty) {
      ukuranValidation.value = 'Mohon mengisi ukuran produk';
    } else {
      ukuranValidation.value = null;
    }
    update();
  }

  onChangePrice(String value) {
    if (value.isEmpty) {
      priceValidation.value = 'Mohon mengisi harga produk';
    } else {
      priceValidation.value = null;
    }
    update();
  }

  onSKUChange(String value) {
    if (value.isEmpty) {
      skuValidation.value = 'Mohon mengisi sku produk';
    } else {
      skuValidation.value = null;
    }
    update();
  }

  onSubmit(BuildContext context, {String? dataKey}) async {
    onChangeName(nameController.text);
    onChangeStock(stockController.text);
    onSKUChange(skuController.text);

    if (nameValidation.value == null &&
        stockValidation.value == null &&
        skuValidation.value == null) {
      bool validationSKU = dataKey == null ? false : true;

      if (dataKey == null) {
        DatabaseReference ref =
            DatabaseHelper.accessDB().ref('products/${skuController.text}');
        DataSnapshot refData = await ref.get();
        if (!refData.exists) {
          validationSKU = true;
        }
      }

      if (validationSKU) {
        DatabaseReference ref =
            DatabaseHelper.accessDB().ref('products/${skuController.text}');

        EasyLoading.show();
        ref.set({
          'name': nameController.text,
          'stock': stockController.text,
          'harga': priceController.text,
          'ukuran': ukuranController.text,
          'created_at': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
        });
        EasyLoading.dismiss();
        Get.back();
        if (context.mounted) {
          showSnackbar(context,
              title: 'Simpan Produk',
              message: 'Berhasil menyimpan produk, mohon coba kembali',
              customColor: Colors.green);
        }
      } else {
        if (context.mounted) {
          showSnackbar(context,
              title: 'Simpan Produk',
              message: 'SKU sudah ada',
              customColor: Colors.orange);
        }
      }
    } else {
      showSnackbar(context,
          title: 'Simpan Produk',
          message: 'Mohon cek kembali isian Anda',
          customColor: Colors.orange);
    }
  }
}
