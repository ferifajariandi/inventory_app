import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokis/app/product_management/product_transaction_controller.dart';
import 'package:stokis/app/product_management/product_transaction_form_page.dart';
import 'package:stokis/shared/font_helper.dart';
import 'package:stokis/shared/theme_helper.dart';

enum ProductTransactionType { stockIn, stockOut }

class ProductTransactionPage extends StatelessWidget {
  final ProductTransactionType type;
  const ProductTransactionPage(
      {super.key, this.type = ProductTransactionType.stockIn});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductTransactionController>(
        init: ProductTransactionController(),
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
                      child: Column(children: [
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
                            type == ProductTransactionType.stockIn
                                ? 'Barang Masuk'
                                : 'Barang Keluar',
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
                                                DatabaseEvent event = snapshot
                                                    .data as DatabaseEvent;

                                                Map<dynamic, dynamic>? data =
                                                    controller.dataAfterFilter(
                                                        event.snapshot.value
                                                            as Map<dynamic,
                                                                dynamic>?,
                                                        type: type);

                                                return data == null
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
                                                    : data.keys.toList().isEmpty
                                                        ? Center(
                                                            child: Text(
                                                              'Data Tidak Ditemukan',
                                                              style: mainFont.copyWith(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          )
                                                        : ListView(
                                                            children:
                                                                List.generate(
                                                                    data.keys
                                                                        .toList()
                                                                        .length,
                                                                    (index) {
                                                              String dataKey = data
                                                                      .keys
                                                                      .toList()[
                                                                  index];

                                                              return Theme(
                                                                data: Theme.of(
                                                                        context)
                                                                    .copyWith(
                                                                        dividerColor:
                                                                            Colors.transparent),
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          16),
                                                                  decoration: const BoxDecoration(
                                                                      border: Border(
                                                                          bottom:
                                                                              BorderSide(color: Colors.black12))),
                                                                  child:
                                                                      ExpansionTile(
                                                                    title:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          '${controller.dateToReadable(data[dataKey]['created_at'].toString().substring(0, 10))} ${data[dataKey]['created_at'].toString().substring(11)}',
                                                                          style: mainFont.copyWith(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Flexible(
                                                                              flex: 4,
                                                                              child: SizedBox(
                                                                                width: double.infinity,
                                                                                child: Text(
                                                                                  'User',
                                                                                  style: mainFont.copyWith(fontSize: 13, color: Colors.black54),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              flex: 6,
                                                                              child: SizedBox(
                                                                                width: double.infinity,
                                                                                child: Text(
                                                                                  data[dataKey]['creator_name'],
                                                                                  style: mainFont.copyWith(fontSize: 13, color: Colors.black54),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Flexible(
                                                                              flex: 4,
                                                                              child: SizedBox(
                                                                                width: double.infinity,
                                                                                child: Text(
                                                                                  'Jumlah Produk',
                                                                                  style: mainFont.copyWith(fontSize: 13, color: Colors.black54),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              flex: 6,
                                                                              child: SizedBox(
                                                                                width: double.infinity,
                                                                                child: Text(
                                                                                  '${data[dataKey]['data'].length} Produk',
                                                                                  style: mainFont.copyWith(fontSize: 13, color: Colors.black54),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    children: [
                                                                      Column(
                                                                        children: List.generate(
                                                                            data[dataKey]['data'].length,
                                                                            (index) {
                                                                          return Container(
                                                                            padding: EdgeInsets.only(
                                                                                top: index == 0 ? 8 : 16,
                                                                                left: 16,
                                                                                right: 16,
                                                                                bottom: index == data[dataKey]['data'].length - 1 ? 0 : 16),
                                                                            decoration:
                                                                                BoxDecoration(border: Border(bottom: BorderSide(color: index == data[dataKey]['data'].length - 1 ? Colors.transparent : Colors.black12))),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Expanded(
                                                                                    child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Text(
                                                                                      data[dataKey]['data'][index]['sku'],
                                                                                      style: mainFont.copyWith(fontSize: 13, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    Text(
                                                                                      data[dataKey]['data'][index]['name'],
                                                                                      style: mainFont.copyWith(
                                                                                        fontSize: 13,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                )),
                                                                                const SizedBox(
                                                                                  width: 8,
                                                                                ),
                                                                                Text(
                                                                                  type == ProductTransactionType.stockOut ? '-${data[dataKey]['data'][index]['update_stock']}' : '+${data[dataKey]['data'][index]['update_stock']}',
                                                                                  style: mainFont.copyWith(fontSize: 20, color: type == ProductTransactionType.stockOut ? Colors.red : Colors.green),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          );
                                              }

                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: secondaryColor),
                                              );
                                            })),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() =>
                                        ProductTransactionFormPage(type: type));
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
                                        '+ Barang Masuk',
                                        style: mainFont.copyWith(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )))
                  ]))));
        });
  }
}
