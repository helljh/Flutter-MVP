import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/ui/font_styles.dart';

class GameFailDialog extends StatelessWidget {
  final VoidCallback onTapHome;
  final VoidCallback onTapRestart;
  const GameFailDialog({
    super.key,
    required this.onTapHome,
    required this.onTapRestart,
  });

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
                  '게임 실패...🥲',
                  style: FontStyles.headerTextBold.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: onTapRestart,
                    child: Text(
                      '재도전',
                      style: FontStyles.largeTextRegular.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onTapHome,
                    child: Text(
                      '홈',
                      style: FontStyles.largeTextRegular.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
