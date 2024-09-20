import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';
import '../widgets/error_mess.dart';
import '../widgets/login_button.dart';
import '../widgets/login_textfield.dart';
import '../widgets/registor_forgot_password.dart';
import '../widgets/social_login_button.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  static const String name = 'login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Đăng nhập'),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 40),
                  LoginTextField(
                    controller: controller.cAccount,
                    hintText: 'Tài khoản',
                    errorText: '',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  const SizedBox(height: 20),
                  LoginTextField(
                    controller: controller.cPass,
                    hintText: 'Mật khẩu',
                    errorText: '',
                    prefixIcon: const Icon(Icons.lock),
                    isPassWord: true,
                  ),
                  const SizedBox(height: 20),
                  ErrorMessage(error: controller.errorAuth),
                  const SizedBox(height: 20),
                  const LoginButtons(),
                  const SizedBox(height: 10),
                  RegisterAndForgotPasswordWidget(
                    create: () {},
                    onError: (String errorMsg) {},
                  ),
                  const SizedBox(height: 10),
                  SocialLoginButtons(onError: (String errorMsg) {}),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2,
                  ),
                ]),
          ),
        ));
  }
}
