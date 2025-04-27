import 'package:mvp_game/core/enum/game_level.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  @override
  final GameLevel level;
  @override
  final bool isCountDownFinished;
  @override
  final int trialCount;
  @override
  final List<int> questionList;
  @override
  final bool isLoading;

  GameState({
    this.level = GameLevel.three,
    this.isCountDownFinished = false,
    this.trialCount = 3,
    this.questionList = const [],
    this.isLoading = false,
  });
}
