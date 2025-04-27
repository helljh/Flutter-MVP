import 'package:flutter/material.dart';

class BasicButton extends StatefulWidget {
  final Widget title;
  final BoxShape shape;
  final VoidCallback onTapStartBtn;
  const BasicButton({
    super.key,
    required this.title,
    required this.onTapStartBtn,
    required this.shape,
  });

  @override
  State<BasicButton> createState() => _BasicButtonState();
}

class _BasicButtonState extends State<BasicButton> {
  bool isPressed = false; // 눌렀는지 여부
  double elevation = 10.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)?.isCurrent == true) {
      // 사용자가 되돌아왔을 때만 초기화
      isPressed = false;
      elevation = 10;
      setState(() {}); // rebuild
    }
  }

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
      onEnd: () {
        if (isPressed) {
          widget.onTapStartBtn();
        }
      },
      decoration: BoxDecoration(
        color: Colors.white,
        //borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: isPressed ? Colors.black : Colors.transparent,
          width: 0.1,
        ),
        shape: widget.shape,
        boxShadow:
            isPressed
                ? [] // 눌렀으면 그림자 제거
                : [
                  const BoxShadow(
                    color: Colors.black38,
                    offset: Offset(2, 2), // 👉 오른쪽 아래로 그림자
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
          child: widget.title,
        ),
      ),
    );
  }
}
