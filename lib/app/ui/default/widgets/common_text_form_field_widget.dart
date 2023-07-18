import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonTextFormFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String? Function(String?) validatorFunction;
  final Icon prefixIcon;
  final String hintText;
  final bool isLoading;

  const CommonTextFormFieldWidget({
    super.key,
    required this.textEditingController,
    required this.textInputType,
    required this.validatorFunction,
    required this.prefixIcon,
    required this.hintText,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.white60,
      ),
    );

    return TextFormField(
      enabled: !isLoading,
      keyboardType: textInputType,
      controller: textEditingController,
      validator: validatorFunction,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        errorBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 6,
        ),
      ),
      style: Get.textTheme.titleMedium,
      obscureText: false,
    );
  }
}
