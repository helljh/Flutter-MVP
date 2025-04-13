import 'package:flutter/material.dart';

import '../../app/ui/font_styles.dart';

class BaseSelectBox extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const BaseSelectBox({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        alignment: Alignment.center,
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(title, style: FontStyles.headerTextRegular),
      ),
    );
  }
}
