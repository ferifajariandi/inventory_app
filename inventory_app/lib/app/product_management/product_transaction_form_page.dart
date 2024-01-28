import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokis/app/product_management/product_transaction_form_controller.dart';
import 'package:stokis/app/product_management/product_transaction_page.dart';
import 'package:stokis/shared/font_helper.dart';
import 'package:stokis/shared/theme_helper.dart';
import 'package:stokis/shared/widgets/rounded_textfield.dart';
import 'package:stokis/shared/widgets/validation_widget.dart';

class ProductTransactionFormPage extends StatelessWidget {
  final ProductTransactionType type;
  const ProductTransactionFormPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductTransactionFormController>(
        init: ProductTransactionFormController(),
        autoRemove: true,
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
                                    child: controller.dataUpdate.isEmpty
                                        ? Center(
                                            child: Text(
                                              'Data Tidak Ditemukan',
                                              style: mainFont.copyWith(
                                                  fontSize: 13,
                                                  color: Colors.black54),
                                            ),
                                          )
                                        : ListView(
                                            children: List.generate(
                                                controller.dataUpdate.length,
                                                (index) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: Colors
                                                                .black12))),
                                                child: ValidationWidget(
                                                  validation: controller
                                                      .dataUpdate[index]
                                                      .validation,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              controller
                                                                  .dataUpdate[
                                                                      index]
                                                                  .data['sku'],
                                                              style: mainFont.copyWith(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              controller
                                                                  .dataUpdate[
                                                                      index]
                                                                  .data['name'],
                                                              style: mainFont
                                                                  .copyWith(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            Text(
                                                              "Stok Saat Ini : ${controller.dataUpdate[index].data['stock']}",
                                                              style: mainFont.copyWith(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                            const SizedBox(
                                                              height: 16,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                controller
                                                                    .onRemoveData(
                                                                        index);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 12,
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .red),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  'Batal',
                                                                  style: mainFont.copyWith(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            type ==
                                                                    ProductTransactionType
                                                                        .stockIn
                                                                ? 'Barang Masuk'
                                                                : 'Barang Keluar',
                                                            style: mainFont
                                                                .copyWith(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 16,
                                                          ),
                                                          SizedBox(
                                                            width: 60,
                                                            child:
                                                                RoundedTextfield(
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .onChangeField(
                                                                        index,
                                                                        value,
                                                                        type:
                                                                            type);
                                                              },
                                                              customAlign:
                                                                  TextAlign
                                                                      .center,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller: controller
                                                                  .dataUpdate[
                                                                      index]
                                                                  .qtyController,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          )),
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.onAddProduct(context);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: secondaryColor)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Tambah Barang',
                                              style: mainFont.copyWith(
                                                  fontSize: 15,
                                                  color: secondaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.onSaveTransaction(
                                                context,
                                                type: type);
                                          },
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
                                              'Simpan',
                                              style: mainFont.copyWith(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )))
                  ]))));
        });
  }
}
