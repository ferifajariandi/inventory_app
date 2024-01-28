import 'package:flutter/material.dart';

class ProductStockTransactionModel {
  TextEditingController qtyController;
  Map<String, dynamic> data;
  String? validation;

  ProductStockTransactionModel(
      {required this.data, required this.qtyController, this.validation});
}
