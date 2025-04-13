// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mvp_game/ui/font_styles.dart';

class GameStartButton extends StatefulWidget {
  final VoidCallback onTapStartBtn;
  const GameStartButton({super.key, required this.onTapStartBtn});

  @override
  State<GameStartButton> createState() => _GameStartButtonState();
}

class _GameStartButtonState extends State<GameStartButton> {
  bool isPressed = false; // 눌렀는지 여부
  double elevation = 10.0;

  void handlePress() async {
    if (!isPressed) {
      setState(() {
        isPressed = true;
        elevation = 0; // 천천히 들어가게 하기 위해 상태만 바꿈
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      onEnd: widget.onTapStartBtn,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: isPressed ? Colors.black : Colors.transparent,
          width: 0.1,
        ),
        boxShadow:
            isPressed
                ? [] // 눌렀으면 그림자 제거
                : [
                  const BoxShadow(
                    color: Colors.black38,
                    offset: Offset(4, 4), // 👉 오른쪽 아래로 그림자
                    blurRadius: 3,
                    spreadRadius: 0.1,
                  ),
                ],
      ),
      child: GestureDetector(
        onTap: handlePress,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: const Text('게임 시작', style: FontStyles.mediumTextRegular),
        ),
      ),
    );
  }
}
