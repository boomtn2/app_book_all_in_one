import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final Widget prefixIcon;
  final bool isPassWord;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.errorText,
    required this.prefixIcon,
    this.isPassWord = false,
  });

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool showPass = true;

  void _changeObscureText() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: showPass,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassWord ? _buttonShowPass() : null,
        errorText: widget.errorText,
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buttonShowPass() {
    return IconButton(
        onPressed: () => _changeObscureText(),
        icon: showPass
            ? const Icon(Icons.visibility_off)
            : const Icon(Icons.visibility));
  }
}
