import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokis/app/product_management/product_management_controller.dart';
import 'package:stokis/app/product_management/product_management_form_page.dart';
import 'package:stokis/shared/font_helper.dart';
import 'package:stokis/shared/theme_helper.dart';
import 'package:stokis/shared/widgets/rounded_textfield.dart';

enum ProductManagementViewType { view, manage, pick }

class ProductManagementMainPage extends StatelessWidget {
  final ProductManagementViewType type;
  const ProductManagementMainPage(
      {super.key, this.type = ProductManagementViewType.view});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductManagementController>(
        init: ProductManagementController(),
        autoRemove: true,
        dispose: (state) {},
        builder: (controller) {
          return Scaffold(
              body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  child: SafeArea(
                      child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                                child: Text(
                              'Produk',
                              style: mainFont.copyWith(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(16),
                              child: RoundedTextfield(
                                controller: controller.searchController,
                                onChanged: (value) {
                                  controller.onSearchChanged(value);
                                },
                                hintText: 'Cari Nama Produk / SKU..',
                                prefixIcon: const Icon(Icons.search),
                              ),
                            ),
                            Expanded(
                                child: controller.dbStream.value == null
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                            color: secondaryColor),
                                      )
                                    : StreamBuilder<Object>(
                                        stream: controller.dbStream.value!,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            DatabaseEvent event =
                                                snapshot.data as DatabaseEvent;

                                            Map<dynamic, dynamic>? data =
                                                controller.dataAfterFilter(event
                                                        .snapshot.value
                                                    as Map<dynamic, dynamic>?);

                                            return data == null
                                                ? Center(
                                                    child: Text(
                                                      'Data Tidak Ditemukan',
                                                      style: mainFont.copyWith(
                                                          fontSize: 13,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  )
                                                : data.keys.toList().isEmpty
                                                    ? Center(
                                                        child: Text(
                                                          'Data Tidak Ditemukan',
                                                          style:
                                                              mainFont.copyWith(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black54),
                                                        ),
                                                      )
                                                    : ListView(
                                                        children: List.generate(
                                                            data.keys
                                                                .toList()
                                                                .length,
                                                            (index) {
                                                          String dataKey = data
                                                              .keys
                                                              .toList()[index];

                                                          return Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16),
                                                            decoration: const BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        color: Colors
                                                                            .black12))),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  dataKey,
                                                                  style: mainFont.copyWith(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Flexible(
                                                                      flex: 4,
                                                                      child:
                                                                          SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          'Nama Produk',
                                                                          style: mainFont.copyWith(
                                                                              fontSize: 13,
                                                                              color: Colors.black54),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      flex: 6,
                                                                      child:
                                                                          SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          data[dataKey]
                                                                              [
                                                                              'name'],
                                                                          style: mainFont.copyWith(
                                                                              fontSize: 13,
                                                                              color: Colors.black54),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Flexible(
                                                                      flex: 4,
                                                                      child:
                                                                          SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          'Stok',
                                                                          style: mainFont.copyWith(
                                                                              fontSize: 13,
                                                                              color: Colors.black54),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      flex: 6,
                                                                      child:
                                                                          SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          data[dataKey]
                                                                              [
                                                                              'stock'],
                                                                          style: mainFont.copyWith(
                                                                              fontSize: 13,
                                                                              color: Colors.black54),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Flexible(
                                                                      flex: 4,
                                                                      child:
                                                                          SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          'Ukuran',
                                                                          style: mainFont.copyWith(
                                                                              fontSize: 13,
                                                                              color: Colors.black54),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      flex: 6,
                                                                      child:
                                                                          SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          data[dataKey]['ukuran'] ??
                                                                              '-',
                                                                          style: mainFont.copyWith(
                                                                              fontSize: 13,
                                                                              color: Colors.black54),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Flexible(
                                                                      flex: 4,
                                                                      child:
                                                                          SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          'Harga',
                                                                          style: mainFont.copyWith(
                                                                              fontSize: 13,
                                                                              color: Colors.black54),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      flex: 6,
                                                                      child:
                                                                          SizedBox(
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Text(
                                                                          data[dataKey]['harga'] ??
                                                                              '-',
                                                                          style: mainFont.copyWith(
                                                                              fontSize: 13,
                                                                              color: Colors.black54),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                type ==
                                                                        ProductManagementViewType
                                                                            .manage
                                                                    ? Container(
                                                                        margin: const EdgeInsets
                                                                            .only(
                                                                            top:
                                                                                16),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                                child: GestureDetector(
                                                                              onTap: () {
                                                                                Get.to(() => ProductManagementFormPage(
                                                                                      dataKey: dataKey,
                                                                                      data: data[dataKey],
                                                                                    ));
                                                                              },
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: 40,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.orange),
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  'Edit',
                                                                                  style: mainFont.copyWith(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            )),
                                                                            const SizedBox(
                                                                              width: 16,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () {
                                                                                controller.deleteProduct(context, dataKey);
                                                                              },
                                                                              child: Container(
                                                                                width: 40,
                                                                                height: 40,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.red),
                                                                                child: const Icon(
                                                                                  Icons.delete,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : type ==
                                                                            ProductManagementViewType.pick
                                                                        ? Container(
                                                                            margin:
                                                                                const EdgeInsets.only(top: 16),
                                                                            child:
                                                                                GestureDetector(
                                                                              onTap: () {
                                                                                Get.back(result: {
                                                                                  'sku': dataKey,
                                                                                  'name': data[dataKey]['name'],
                                                                                  'stock': data[dataKey]['stock']
                                                                                });
                                                                              },
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: 40,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: secondaryColor),
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  'Pilih',
                                                                                  style: mainFont.copyWith(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container()
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                      );
                                          }

                                          return const Center(
                                            child: CircularProgressIndicator(
                                                color: secondaryColor),
                                          );
                                        })),
                            type == ProductManagementViewType.manage
                                ? GestureDetector(
                                    onTap: () {
                                      Get.to(() =>
                                          const ProductManagementFormPage());
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.all(16),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: secondaryColor),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '+ Tambah Produk',
                                          style: mainFont.copyWith(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ))
                    ],
                  ))));
        });
  }
}
