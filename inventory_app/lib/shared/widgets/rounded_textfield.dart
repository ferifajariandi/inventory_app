import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stokis/shared/font_helper.dart';
import 'package:stokis/shared/theme_helper.dart';

class RoundedTextfield extends StatelessWidget {
  final String? hintText;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final bool? obscureText;
  final double? customRadius;
  final Widget? prefixIcon;
  final String? labelText;
  final bool withBorder;
  final Function()? onEditingComplete;
  final String? validation;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final Color? customColorFill;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final bool? enabled;
  final int? maxLength;
  final Function()? onTap;
  final TextEditingController controller;
  final TextAlign? customAlign;

  const RoundedTextfield({
    super.key,
    this.hintText,
    this.onChanged,
    this.onEditingComplete,
    this.prefixWidget,
    this.suffixWidget,
    this.customAlign,
    this.obscureText,
    this.customRadius,
    this.prefixIcon,
    this.labelText,
    this.withBorder = true,
    this.validation,
    this.validator,
    this.keyboardType,
    this.prefixText,
    this.prefixStyle,
    this.focusNode,
    this.contentPadding,
    this.maxLines,
    this.customColorFill,
    this.inputFormatters,
    this.enabled,
    this.maxLength,
    this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: customAlign ?? TextAlign.left,
      onEditingComplete: onEditingComplete,
      enabled: enabled ?? true,
      validator: (value) {
        return validator == null ? null : validator!(value!);
      },
      onChanged: onChanged,
      maxLength: maxLength,
      focusNode: focusNode,
      onTap: onTap,
      cursorColor: Theme.of(context).primaryColor,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      style: mainFont.copyWith(fontSize: 12),
      decoration: InputDecoration(
          labelText: labelText,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.black38)),
          labelStyle: mainFont.copyWith(color: Theme.of(context).primaryColor),
          hintText: hintText,
          focusedBorder: withBorder
              ? OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: secondaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(customRadius ?? 6),
                )
              : null,
          fillColor: customColorFill ?? Colors.white,
          filled: true,
          prefixText: prefixText,
          prefix: prefixWidget,
          prefixStyle:
              prefixStyle ?? mainFont.copyWith(fontWeight: FontWeight.bold),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(
                vertical: 9,
                horizontal: 12,
              ),
          errorMaxLines: 10,
          hintStyle: mainFont.copyWith(fontSize: 12, color: Colors.black38),
          prefixIcon: prefixIcon,
          suffixIcon: suffixWidget,
          border: InputBorder.none),
    );
  }
}
