import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

showSnackbar(BuildContext context,
    {Color? customColor, String title = '', String message = ''}) {
  Flushbar(
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    duration: const Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: customColor ?? Theme.of(context).primaryColor,
    message: message,
    title: title,
  ).show(context);
}
