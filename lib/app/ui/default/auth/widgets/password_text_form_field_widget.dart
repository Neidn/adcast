import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordTextFormFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String? Function(String?) validatorFunction;
  final Icon prefixIcon;
  final String hintText;
  final bool isObscure;
  final bool isLoading;
  final void Function()? suffixIconOnPressed;

  const PasswordTextFormFieldWidget({
    super.key,
    required this.textEditingController,
    required this.textInputType,
    required this.validatorFunction,
    required this.prefixIcon,
    required this.hintText,
    required this.isLoading,
    this.isObscure = false,
    this.suffixIconOnPressed,
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
      keyboardType: textInputType,
      controller: textEditingController,
      validator: validatorFunction,
      obscureText: isObscure,
      enabled: !isLoading,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: IconButton(
          onPressed: () {
            if (suffixIconOnPressed != null) {
              suffixIconOnPressed!();
            }
          },
          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
        ),
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
    );
  }
}
