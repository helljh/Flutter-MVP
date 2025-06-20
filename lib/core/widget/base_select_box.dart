import 'package:flutter/material.dart';

import '../ui/font_styles.dart';

class BaseSelectBox extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  const BaseSelectBox({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: FontStyles.headerTextRegular),
            const SizedBox(height: 5),
            if (subtitle != null)
              Text(subtitle!, style: FontStyles.smallTextRegular),
          ],
        ),
      ),
    );
  }
}
