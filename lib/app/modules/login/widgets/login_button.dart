import 'package:audio_youtube/app/modules/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginButtons extends GetView<LoginController> {
  const LoginButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll((Color(0xFFF27522))),
            ),
            onPressed: () async {
              controller.signInWithEmail();
            },
            child: const Text(
              'Đăng nhập',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
