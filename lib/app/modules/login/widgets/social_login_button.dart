import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../controllers/login_controller.dart';

class SocialLoginButtons extends GetView<LoginController> {
  final Function(String) onError;

  const SocialLoginButtons({super.key, required this.onError});

  void _loginGoogle(BuildContext context) async {
    final data = await controller.signInWithGoogle();

    if (data == null) {
      onError('Lỗi đăng nhập Google');
    }
  }

  void _loginApple() async {}

  void _loginFaceBook() async {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Đăng nhập với'),
            ),
            Expanded(
              child: Divider(
                color: Colors.black,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buttonIcon(Icons.facebook, _loginFaceBook, Colors.blue),
            _buttonIcon(Icons.apple, _loginApple, Colors.black),
            _buttonIcon(Icons.g_mobiledata_rounded, () => _loginGoogle(context),
                Colors.green),
          ],
        ),
      ],
    );
  }

  Widget _buttonIcon(IconData iconData, Function fct, Color color) {
    return InkWell(
      onTap: () => fct(),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: color),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: color,
            size: 42,
          ),
        ),
      ),
    );
  }
}
