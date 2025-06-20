import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mvp_game/core/widget/game_pad.dart';

enum Direction { up, down, left, right, upLeft, upRight, downLeft, downRight }

class DirectionPad extends GamePad {
  const DirectionPad({
    super.key,
    required super.state,
    required super.decreaseCount,
    required super.gameSuccess,
    required super.gameFail,
  });

  @override
  State<DirectionPad> createState() => _DirectionPadState();
}

class _DirectionPadState extends State<DirectionPad>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<bool> _cellFlipped;
  late List<int> _answerList;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    final count = widget.state.level.totalCount;
    _cellFlipped = List.generate(count, (_) => false);

    _controllers = List.generate(count, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    });

    _animations =
        _controllers.map((controller) {
          return Tween<double>(begin: 0, end: pi).animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInOut),
          );
        }).toList();

    _answerList = [];
    for (int targetDirection = 1; targetDirection <= 9; targetDirection++) {
      final index = widget.state.questionList.indexOf(targetDirection);
      if (index != -1) _answerList.add(index);
    }

    if (widget.state.isCountDownFinished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _flipAll();
      });
    }
  }

  @override
  void didUpdateWidget(covariant DirectionPad oldWidget) {
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
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildCell({IconData? icon}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: icon != null ? Icon(icon, size: 32, color: Colors.black) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: widget.state.level.size,
      padding: const EdgeInsets.all(16),
      children: List.generate(widget.state.level.totalCount, (index) {
        int directionIndex =
            widget.state.questionList.length > index
                ? widget.state.questionList[index]
                : -1;
        IconData? icon = getIconFromDirection(directionIndex);

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
                await Future.delayed(const Duration(milliseconds: 600), () {
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
              final rotation = _animations[index].value;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(rotation),
                child: Stack(
                  children: [
                    if (rotation <= pi / 2)
                      _buildCell(icon: icon)
                    else
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: _buildCell(),
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

  IconData? getIconFromDirection(int index) {
    switch (index) {
      case 1:
        return Icons.arrow_upward;
      case 2:
        return Icons.north_east;
      case 3:
        return Icons.arrow_forward;
      case 4:
        return Icons.south_east;
      case 5:
        return Icons.arrow_downward;
      case 6:
        return Icons.south_west;
      case 7:
        return Icons.arrow_back;
      case 8:
        return Icons.north_west;
      default:
        return null;
    }
  }
}
