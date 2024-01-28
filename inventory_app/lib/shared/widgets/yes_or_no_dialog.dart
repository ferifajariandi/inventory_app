import 'package:flutter/material.dart';
import 'package:stokis/shared/font_helper.dart';
import 'package:stokis/shared/theme_helper.dart';

Future<bool> yesOrNoDialog(BuildContext context,
    {required String title,
    required String desc,
    String? customYes,
    double? customSizeYes,
    double? customSizeNo,
    String? customNo}) async {
  bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black12,
            alignment: Alignment.center,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: mainFont.copyWith(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      desc,
                      textAlign: TextAlign.center,
                      style: mainFont.copyWith(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(children: [
                      Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: secondaryColor)),
                              child: Text(
                                customNo ?? 'Tidak',
                                style: mainFont.copyWith(
                                    fontSize: customSizeNo ?? 13,
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      const SizedBox(width: 8),
                      Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: secondaryColor),
                              alignment: Alignment.center,
                              child: Text(
                                customYes ?? 'Ya',
                                style: mainFont.copyWith(
                                    fontSize: customSizeYes ?? 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ])
                  ],
                )));
      });

  return result != null;
}
