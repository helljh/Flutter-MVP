import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_action.freezed.dart';

@freezed
sealed class GameAction with _$GameAction {
  const factory GameAction.onCountDownFinished(int value) = OnCountDownFinished;
  const factory GameAction.decreaseCount(int count) = DecreaseCount;
  const factory GameAction.gameSuccess() = GameSuccess;
  const factory GameAction.gameFail() = GameFail;
}
