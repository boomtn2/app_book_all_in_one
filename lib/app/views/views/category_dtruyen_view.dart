import 'package:flutter/material.dart';

import '../../core/values/text_styles.dart';

Map<String, String> category = {
  'Điền văn': '/truyen-dien-van-hay/',
  'Nữ cường': '/truyen-nu-cuong-hay/',
  'Xuyên nhanh': '/xuyen-nhanh/',
  'Hài hước': '/hai-huoc/',
  'Hiện đại': '/hien-dai/',
  'Cổ đại': '/co-dai/',
  'Xuyên sách': '/xuyen-sach/',
  'Mạt thế': '/mat-the/',
  'Huyền huyễn': '/huyen-huyen/',
  'Trọng sinh': "/trong-sinh/",
  'Dị năng': '/di-nang/'
};

class CategoryDtruyenView extends StatelessWidget {
  const CategoryDtruyenView({super.key, required this.callBack});
  final Function(String) callBack;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: MediaQuery.sizeOf(context).width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: category.entries.map(
          (e) {
            return _button(e.key, e.value, callBack);
          },
        ).toList(),
      ),
    );
  }

  Widget _button(String title, String value, Function(String) callBack) {
    return InkWell(
      onTap: () {
        callBack(value);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.black54, width: 1)),
        child: Center(
          child: Text(
            title,
            style: afaca.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
