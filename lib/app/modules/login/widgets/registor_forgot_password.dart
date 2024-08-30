import 'package:flutter/material.dart';

class RegisterAndForgotPasswordWidget extends StatelessWidget {
  const RegisterAndForgotPasswordWidget(
      {super.key, required this.onError, required this.create});
  final Function(String) onError;
  final Function create;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            create();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Đăng ký',
              style: TextStyle(
                color: Colors.blue,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        InkWell(
          onTap: () async {},
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Lấy lại mật khẩu',
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
