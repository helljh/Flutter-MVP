import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mvp_game/core/widget/game_pad.dart';

class ColorPad extends GamePad {
  const ColorPad({
    super.key,
    required super.state,
    required super.decreaseCount,
    required super.gameSuccess,
    required super.gameFail,
  });

  @override
  State<ColorPad> createState() => _ColorPadState();
}

class _ColorPadState extends State<ColorPad> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<bool> _cellFlipped;
  int _currentIndex = 0;
  late List<int> _answerList;

  @override
  void initState() {
    super.initState();
    _cellFlipped = List.generate(widget.state.level.totalCount, (_) => false);

    _controllers = List.generate(widget.state.level.totalCount, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    });

    _animations =
        _controllers
            .map(
              (controller) => Tween<double>(begin: 0, end: pi).animate(
                CurvedAnimation(parent: controller, curve: Curves.easeInOut),
              ),
            )
            .toList();

    // 색상 인덱스 1~9에 해당하는 셀의 위치를 answerList로 저장
    _answerList = [];
    for (int targetColor = 1; targetColor <= 9; targetColor++) {
      final index = widget.state.questionList.indexOf(targetColor);
      if (index != -1) _answerList.add(index);
    }

    if (widget.state.isCountDownFinished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _flipAll();
      });
    }
  }

  @override
  void didUpdateWidget(covariant ColorPad oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.state.isCountDownFinished &&
        widget.state.isCountDownFinished) {
      _flipAll();
    }
  }

  void _flipAll() {
    for (int i = 0; i < widget.state.level.totalCount; i++) {
      _controllers[i].forward();
      _cellFlipped[i] = true;
    }
  }

  void _flipCell(int index) {
    if (_cellFlipped[index]) {
      _controllers[index].reverse();
    } else {
      _controllers[index].forward();
    }
    setState(() {
      _cellFlipped[index] = !_cellFlipped[index];
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildCell(Color? color) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        color: color ?? Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: widget.state.level.size,
      padding: const EdgeInsets.all(16),
      children: List.generate(widget.state.level.totalCount, (index) {
        int colorIndex =
            widget.state.questionList.length > index
                ? widget.state.questionList[index]
                : -1;
        Color? displayColor = _getColorFromIndex(colorIndex);

        return GestureDetector(
          onTap: () async {
            if (widget.state.isCountDownFinished) {
              if (_currentIndex < _answerList.length &&
                  index == _answerList[_currentIndex]) {
                _flipCell(index);
                _currentIndex++;
                if (_currentIndex >= _answerList.length) {
                  await Future.delayed(const Duration(milliseconds: 500));
                  widget.gameSuccess();
                }
              } else {
                _flipCell(index);
                await Future.delayed(const Duration(milliseconds: 500), () {
                  _flipCell(index);
                });
                await widget.decreaseCount(widget.state.trialCount);
                if (widget.state.trialCount == 1 && context.mounted) {
                  widget.gameFail();
                }
              }
            }
          },
          child: AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              double rotation = _animations[index].value;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(rotation),
                child: Stack(
                  children: [
                    if (rotation <= pi / 2)
                      _buildCell(displayColor)
                    else
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: _buildCell(null),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Color? _getColorFromIndex(int index) {
    switch (index) {
      case 1:
        return Colors.red; // 빨강 - Vivid Red
      case 2:
        return Colors.orange; // 주황 - Bright Orange
      case 3:
        return Colors.yellow; // 노랑 - Vivid Yellow
      case 4:
        return Colors.green; // 초록 - Neon Green
      case 5:
        return Colors.blue; // 하늘 - Bright Sky Blue
      case 6:
        return Colors.indigo; // 파랑 - Vivid Blue
      case 7:
        return Colors.purple; // 보라 - Electric Purple
      case 8:
        return Colors.brown; // 갈색 - Saddle Brown
      case 9:
        return Colors.black; // 검정 - Jet Black
      default:
        return Colors.white; // -1 같은 빈 칸
    }
  }
}
