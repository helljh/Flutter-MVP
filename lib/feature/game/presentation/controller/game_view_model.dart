import 'package:flutter/material.dart';
import 'package:mvp_game/core/enum/game_level.dart';
import 'package:mvp_game/feature/game/presentation/controller/game_state.dart';

class GameViewModel with ChangeNotifier {
  GameState _state = const GameState();

  GameState get state => _state;

  GameViewModel();

  void setGameData(GameLevel level) {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    // 1부터 9까지의 숫자만 생성하고 섞기
    List<int> numbers = List.generate(9, (index) => index + 1);

    // 전체 격자판 크기만큼의 리스트 생성 (비어있는 칸은 -1로 표시)
    final questionList = List.generate(level.totalCount, (index) {
      if (index < numbers.length) {
        return numbers[index]; // 1-9 중 하나의 숫자 배치
      } else {
        return -1; // 빈 칸은 -1로 표시
      }
    });

    // 숫자들의 위치를 다시 한번 섞기
    questionList.shuffle();

    _state = state.copyWith(
      level: level,
      questionList: questionList,
      isLoading: false,
    );

    notifyListeners();
  }

  void changeCountDownFinished() {
    _state = state.copyWith(isCountDownFinished: true);
    notifyListeners();
  }

  void decreaseTrialCount(int count) {
    _state = state.copyWith(trialCount: --count);
    notifyListeners();
  }
}
