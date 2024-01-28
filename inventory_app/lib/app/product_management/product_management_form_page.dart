import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stokis/app/product_management/product_management_form_controller.dart';
import 'package:stokis/shared/font_helper.dart';
import 'package:stokis/shared/theme_helper.dart';
import 'package:stokis/shared/widgets/rounded_textfield.dart';
import 'package:stokis/shared/widgets/validation_widget.dart';

class ProductManagementFormPage extends StatelessWidget {
  final Map<dynamic, dynamic>? data;
  final String? dataKey;
  const ProductManagementFormPage({super.key, this.data, this.dataKey});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductManagementFormController>(
        init: ProductManagementFormController(),
        initState: (state) {
          Future.delayed(const Duration(seconds: 0), () {
            state.controller?.onInitData(dataKey: dataKey, data: data);
          });
        },
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
                              'Form Produk',
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
                                child: ListView(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Nama Produk',
                                  style: mainFont.copyWith(
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                ValidationWidget(
                                  validation: controller.nameValidation.value,
                                  child: RoundedTextfield(
                                    controller: controller.nameController,
                                    onChanged: (value) {
                                      controller.onChangeName(value);
                                    },
                                    hintText: 'Nama Produk',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Stok',
                                  style: mainFont.copyWith(
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                ValidationWidget(
                                  validation: controller.stockValidation.value,
                                  child: RoundedTextfield(
                                    controller: controller.stockController,
                                    onChanged: (value) {
                                      controller.onChangeStock(value);
                                    },
                                    keyboardType: TextInputType.number,
                                    hintText: 'Stok',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Ukuran',
                                  style: mainFont.copyWith(
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                ValidationWidget(
                                  validation: controller.ukuranValidation.value,
                                  child: RoundedTextfield(
                                    controller: controller.ukuranController,
                                    onChanged: (value) {
                                      controller.onChangeUkuran(value);
                                    },
                                    hintText: 'Ukuran',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'Harga',
                                  style: mainFont.copyWith(
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                ValidationWidget(
                                  validation: controller.priceValidation.value,
                                  child: RoundedTextfield(
                                    controller: controller.priceController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      controller.onChangePrice(value);
                                    },
                                    hintText: 'Harga',
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'SKU',
                                  style: mainFont.copyWith(
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                ValidationWidget(
                                  validation: controller.skuValidation.value,
                                  child: RoundedTextfield(
                                    controller: controller.skuController,
                                    enabled: dataKey == null,
                                    onChanged: (value) {
                                      controller.onSKUChange(value);
                                    },
                                    hintText: 'SKU',
                                  ),
                                ),
                              ],
                            )),
                            GestureDetector(
                              onTap: () {
                                controller.onSubmit(context, dataKey: dataKey);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
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
                            )
                          ],
                        ),
                      ))
                    ],
                  ))));
        });
  }
}
