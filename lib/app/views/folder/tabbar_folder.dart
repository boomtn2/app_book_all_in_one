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
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorders.borderCardItem,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.secondaryContainer,
            width: 2,
          ),
          left: BorderSide(
            color: theme.colorScheme.secondaryContainer,
            width: 2,
          ),
          right: BorderSide(
            color: theme.colorScheme.secondaryContainer,
            width: 2,
          ),
        ),
      ),
      child: Wrap(
          children: tabs.entries
              .map((e) => _buttonFolder(
                  e.key,
                  e.value,
                  theme.colorScheme.primary,
                  theme.colorScheme.secondaryContainer))
              .toList()),
    );
  }

  Widget _buttonFolder(String title, bool enable, Color color, Color hide) {
    final borderSide = enable
        ? BorderSide(
            color: color,
            width: 3,
          )
        : BorderSide(
            color: hide,
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
          style: headerStyle.copyWith(color: enable ? color : hide),
        ),
      ),
    );
  }
}
