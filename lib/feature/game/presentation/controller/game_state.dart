import 'package:mvp_game/core/enum/game_level.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

@freezed
abstract class GameState with _$GameState {
  const factory GameState({
    @Default(GameLevel.three) GameLevel level,
    @Default(false) bool isCountDownFinished,
    @Default(3) int trialCount,
    @Default([]) List<int> questionList,
    @Default(false) bool isLoading,
  }) = _GameState;
}
