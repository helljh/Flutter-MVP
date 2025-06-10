import 'package:flutter/material.dart';
import 'package:mvp_game/core/enum/game_level.dart';
import 'package:mvp_game/core/enum/game_type.dart';

class GameFlowViewModel extends ChangeNotifier {
  GameType? _selectedGameType;
  GameLevel? _selectedLevel;

  GameType? get selectedGameType => _selectedGameType;
  GameLevel? get selectedLevel => _selectedLevel;

  void selectGameType(GameType type) {
    _selectedGameType = type;
    notifyListeners();
  }

  void selectLevel(GameLevel level) {
    _selectedLevel = level;
    notifyListeners();
  }
}
