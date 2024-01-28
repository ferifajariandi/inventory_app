import 'package:flutter/material.dart';
import 'package:stokis/shared/font_helper.dart';

class ValidationWidget extends StatelessWidget {
  final String? validation;
  final Widget child;
  const ValidationWidget({super.key, this.validation, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        validation == null
            ? const SizedBox()
            : Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  validation!,
                  style: mainFont.copyWith(fontSize: 10, color: Colors.red),
                ),
              ),
      ],
    );
  }
}
