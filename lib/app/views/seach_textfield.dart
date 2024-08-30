import 'package:flutter/material.dart';

class SearchTextFieldView extends StatelessWidget {
  const SearchTextFieldView({super.key});

  @override
  Widget build(BuildContext context) {
    return _itemAppBar();
  }

  Widget _itemAppBar() {
    return Center(
      child: SizedBox(
        height: 40,
        child: TextField(
          decoration: InputDecoration(
              hintStyle: const TextStyle(fontSize: 14),
              hintText: 'Tìm kiếm',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ),
                borderSide: const BorderSide(color: Colors.white),
              ),
              suffixIcon: const Icon(Icons.search)),
        ),
      ),
    );
  }
}
