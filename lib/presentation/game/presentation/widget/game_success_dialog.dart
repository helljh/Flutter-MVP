// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/ui/font_styles.dart';

class GameSuccessDialog extends StatelessWidget {
  final VoidCallback onTapHome;

  const GameSuccessDialog({super.key, required this.onTapHome});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.transparent,
            content: Column(
              children: [
                Text(
                  '게임 성공!!🎉',
                  style: FontStyles.headerTextBold.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            actions: [
              GestureDetector(
                onTap: onTapHome,
                child: Center(
                  child: Text(
                    '홈',
                    style: FontStyles.largeTextRegular.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
