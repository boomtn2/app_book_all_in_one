import 'package:flutter/material.dart';

import '../../core/values/app_borders.dart';
import '../../core/values/text_styles.dart';

class TabbarFolder extends StatefulWidget {
  const TabbarFolder({super.key, required this.tabs, required this.fct});
  final Map<String, bool> tabs;
  final Function(String value) fct;
  @override
  State<TabbarFolder> createState() => _TabbarFolderState();
}

class _TabbarFolderState extends State<TabbarFolder> {
  Map<String, bool> tabs = {};

  @override
  void initState() {
    tabs.addAll(widget.tabs);
    super.initState();
  }

  void _action(String key) {
    tabs.updateAll((key, value) => value = false);
    tabs[key] = true;
    widget.fct(key);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: AppBorders.borderCardItem,
          border: const Border(
            top: BorderSide(
              color: Colors.black,
              width: 2,
            ),
            left: BorderSide(
              color: Colors.black,
              width: 2,
            ),
            right: BorderSide(
              color: Colors.black,
              width: 2,
            ),
          )),
      child: Wrap(
          children:
              tabs.entries.map((e) => _buttonFolder(e.key, e.value)).toList()),
    );
  }

  Widget _buttonFolder(String title, bool enable) {
    final borderSide = enable
        ? const BorderSide(
            color: Colors.blue,
            width: 3,
          )
        : const BorderSide(
            color: Color.fromARGB(86, 158, 158, 158),
            width: 1,
          );
    return InkWell(
      onTap: () {
        setState(() {
          _action(title);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius:
                enable ? AppBorders.borderCardItem : BorderRadius.circular(2),
            border: Border(
              bottom: borderSide,
              right: enable ? BorderSide.none : borderSide,
            )),
        child: Text(
          title.toUpperCase(),
          style:
              headerStyle.copyWith(color: enable ? Colors.blue : Colors.grey),
        ),
      ),
    );
  }
}
