import 'package:flutter/material.dart';

class BackGroundLoginPage extends StatelessWidget {
  const BackGroundLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: Image.asset(
        'assets/images/bgr_login.png',
        fit: BoxFit.fill,
      ),
    );
  }
}
