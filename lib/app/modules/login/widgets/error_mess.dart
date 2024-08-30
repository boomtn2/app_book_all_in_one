import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String error;
  const ErrorMessage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return error.isNotEmpty
        ? Text(
            error,
            style: const TextStyle(color: Colors.red),
          )
        : const SizedBox();
  }
}
