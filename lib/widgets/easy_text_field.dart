import 'package:flutter/material.dart';
import 'package:desktop_test/constant/color.dart';
import 'package:desktop_test/constant/dimen.dart';

class EasyTextField extends StatelessWidget {
  const EasyTextField(
      {super.key,
      required this.controller,
      this.color,
      required this.hintText,
      this.focusNode,
      this.iconData,
      this.suffix,
      this.obscure = false,
      this.validator,
      this.onFieldSubmitted,
      this.isReadOnly = false,
      this.onChanged,
      this.inputType = TextInputType.text});

  final TextEditingController controller;
  final Color? color;
  final String hintText;
  final FocusNode? focusNode;
  final IconData? iconData;
  final Widget? suffix;
  final bool obscure;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      obscureText: obscure,
      focusNode: focusNode,
      onChanged: onChanged == null ? (value) {} : (value) => onChanged!(value),
      validator: (value) {
        if (validator != null) {
          return validator!(value);
        } else {
          return null;
        }
      },
      onFieldSubmitted: onFieldSubmitted == null
          ? (value) {}
          : (value) => onFieldSubmitted!(value),
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: kHintTextColor, fontSize: kFs14x),
        prefixIcon: iconData == null ? null : Icon(iconData),
        fillColor: color ?? kWhiteColor,
        filled: true,
        suffixIcon: suffix,
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(kBr10x))),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(kBr10x))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.2),
            borderRadius: BorderRadius.all(Radius.circular(kBr10x))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0.6),
            borderRadius: BorderRadius.all(Radius.circular(kBr10x))),
      ),
    );
  }
}
