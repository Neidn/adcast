import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/controller/auth/login_controller.dart';

import '/app/ui/default/auth/widgets/password_text_form_field_widget.dart';
import '/app/ui/default/auth/widgets/login_form_widget.dart';
import '/app/ui/default/widgets/common_text_form_field_widget.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetX<LoginController>(
          builder: (_) {
            return Form(
              key: _.loginFormKey,
              child: Column(
                children: [
                  Flexible(flex: 1, child: Container()),

                  // Logo
                  Flexible(
                    flex: 2,
                    child: SizedBox(
                      width: Get.width * 0.5,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),

                  // Login Form
                  LoginFormWidget(
                    formWidget: Column(
                      children: [
                        CommonTextFormFieldWidget(
                          textEditingController: _.idController,
                          textInputType: TextInputType.text,
                          validatorFunction: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your ID';
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'ID',
                          isLoading: _.isLoading,
                        ),
                        const SizedBox(height: 24),
                        PasswordTextFormFieldWidget(
                          textEditingController: _.passwordController,
                          textInputType: TextInputType.text,
                          validatorFunction: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.vpn_key_sharp),
                          suffixIconOnPressed: () {
                            _.togglePasswordVisibility();
                          },
                          isObscure: _.isObscure,
                          isLoading: _.isLoading,
                        ),
                        const SizedBox(height: 20),
                        _.isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  if (_.loginFormKey.currentState!.validate()) {
                                    _.login();
                                  }
                                },
                                child: const Text('Login'),
                              ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                  Flexible(flex: 3, child: Container()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
