// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../ui/font_styles.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool? centerTitle;
  final Widget? leading;
  final List<Widget>? actions;
  const BaseAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          title == null ? 'MVP' : title!,
          style: FontStyles.largeTextRegular,
        ),
      ),
      centerTitle: centerTitle ?? false,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
