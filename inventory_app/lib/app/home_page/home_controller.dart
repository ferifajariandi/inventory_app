import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stokis/app/login/login_page.dart';
import 'package:stokis/app/product_management/product_management_main_page.dart';
import 'package:stokis/app/product_management/product_transaction_page.dart';
import 'package:stokis/app/profile/profile_update_page.dart';
import 'package:stokis/shared/global_data/user_logged.dart';
import 'package:stokis/shared/widgets/yes_or_no_dialog.dart';

enum HomeMenu { updateProfile, searchProduct, manageProduct, stockIn, stockOut }

class HomeController extends GetxController {
  RxList<HomeMenu> dataMenu = RxList();

  IconData getMenuIcon(HomeMenu data) {
    if (data == HomeMenu.searchProduct) {
      return Icons.search;
    } else if (data == HomeMenu.manageProduct) {
      return Icons.check_box_rounded;
    } else if (data == HomeMenu.stockIn) {
      return Icons.download_rounded;
    } else if (data == HomeMenu.stockOut) {
      return Icons.upload_rounded;
    } else if (data == HomeMenu.updateProfile) {
      return Icons.account_circle;
    }

    return Icons.no_encryption;
  }

  String getMenuTitle(HomeMenu data) {
    if (data == HomeMenu.searchProduct) {
      return 'Cari Produk';
    } else if (data == HomeMenu.manageProduct) {
      return 'Manage Produk';
    } else if (data == HomeMenu.stockIn) {
      return 'Barang Masuk';
    } else if (data == HomeMenu.stockOut) {
      return 'Barang Keluar';
    } else if (data == HomeMenu.updateProfile) {
      return 'Ubah Profil';
    }

    return '';
  }

  onMenuTap(HomeMenu data) {
    if (data == HomeMenu.updateProfile) {
      Get.to(() => const ProfileUpdatePage());
    } else if (data == HomeMenu.manageProduct) {
      Get.to(() => const ProductManagementMainPage(
            type: ProductManagementViewType.manage,
          ));
    } else if (data == HomeMenu.searchProduct) {
      Get.to(() => const ProductManagementMainPage(
            type: ProductManagementViewType.view,
          ));
    } else if (data == HomeMenu.stockIn) {
      Get.to(() => const ProductTransactionPage(
            type: ProductTransactionType.stockIn,
          ));
    } else if (data == HomeMenu.stockOut) {
      Get.to(() => const ProductTransactionPage(
            type: ProductTransactionType.stockOut,
          ));
    }
  }

  onSetMenu() {
    if (UserLogged.getUser()['role'] == 'admin') {
      dataMenu.value = [
        HomeMenu.searchProduct,
        HomeMenu.manageProduct,
        HomeMenu.stockIn,
        HomeMenu.stockOut,
        HomeMenu.updateProfile,
      ];
    } else {
      dataMenu.value = [
        HomeMenu.searchProduct,
        HomeMenu.updateProfile,
      ];
    }
  }

  onLogout(BuildContext context) async {
    yesOrNoDialog(context,
            title: 'Logout', desc: 'Apakah Anda yakin untuk keluar?')
        .then((value) async {
      if (value) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();

        Get.offAll(() => const LoginPage());
      }
    });
  }

  Future<String> getImageUrl(String path) async {
    Reference sr = FirebaseStorage.instance.ref();
    return await sr.child(path).getDownloadURL();
  }

  @override
  void onInit() {
    super.onInit();
    onSetMenu();
  }
}
