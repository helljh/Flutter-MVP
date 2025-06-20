import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mvp_game/core/widget/game_pad.dart';

import '../../../../core/ui/font_styles.dart';

class NumberPad extends GamePad {
  const NumberPad({
    super.key,
    required super.state,
    required super.decreaseCount,
    required super.gameSuccess,
    required super.gameFail,
  });

  @override
  State<NumberPad> createState() => _NumberPadState();
}

class _NumberPadState extends State<NumberPad> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<bool> _cellFlipped;
  int _currentAnswer = 1; // 현재 눌러야 할 숫자

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

    if (widget.state.isCountDownFinished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _flipAll();
      });
    }
  }

  @override
  void didUpdateWidget(covariant NumberPad oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 게임 시작 시 셀 뒤집기
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

  Widget _buildCell(int? number) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child:
          (number != null && number != -1) // -1이 아닐 때만 숫자 표시
              ? Text(number.toString(), style: FontStyles.mediumTextRegular)
              : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: widget.state.level.size,
      padding: const EdgeInsets.all(16),
      children: List.generate(widget.state.level.totalCount, (index) {
        int number = widget.state.questionList[index];

        return GestureDetector(
          onTap: () async {
            if (widget.state.isCountDownFinished) {
              // number != -1 조건 제거
              if (number == _currentAnswer) {
                _flipCell(index); // 정답이면 뒤집기 유지
                _currentAnswer++;
                if (_currentAnswer > 9) {
                  await Future.delayed(const Duration(milliseconds: 500));
                  widget.gameSuccess();
                }
              } else {
                // 오답이거나 빈칸이면 잠깐 뒤집었다 다시 뒤집기
                if (number > _currentAnswer || number == -1) {
                  _flipCell(index);
                  await Future.delayed(const Duration(milliseconds: 500), () {
                    _flipCell(index);
                  });
                }
                await widget.decreaseCount(widget.state.trialCount);
                if (widget.state.trialCount == 1) {
                  if (context.mounted) {
                    widget.gameFail();
                  }
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
                      _buildCell(number)
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
}
