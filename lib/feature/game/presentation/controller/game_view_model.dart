import 'package:flutter/material.dart';
import 'package:mvp_game/core/enum/game_level.dart';
import 'package:mvp_game/core/enum/game_type.dart'; // 새로 enum GameType 선언했다고 가정
import 'package:mvp_game/feature/game/presentation/controller/game_state.dart';

class GameViewModel with ChangeNotifier {
  GameState _state = const GameState();
  GameState get state => _state;

  GameViewModel();

  void setGameData(GameLevel level, GameType gameType) {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    late List<int> questionList;

    switch (gameType) {
      case GameType.number:
        // 1~9 숫자
        final numbers = List.generate(9, (index) => index + 1);
        questionList = _fillAndShuffle(numbers, level.totalCount);
        break;

      case GameType.color:
        // 1~9 색상
        final colors = List.generate(9, (index) => index + 1);
        questionList = _fillAndShuffle(colors, level.totalCount);
        break;

      case GameType.direction:
        // 1~8 방향 (enum index + 1)
        final directions = List.generate(8, (index) => index + 1);
        questionList = _fillAndShuffle(directions, level.totalCount);
        break;
    }

    _state = state.copyWith(
      level: level,
      questionList: questionList,
      isLoading: false,
    );

    notifyListeners();
  }

  /// 리스트를 totalCount만큼 채우고 셔플
  List<int> _fillAndShuffle(List<int> baseList, int totalCount) {
    final list = List.generate(totalCount, (index) {
      if (index < baseList.length) {
        return baseList[index];
      }
      return -1;
    });
    list.shuffle();
    return list;
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
