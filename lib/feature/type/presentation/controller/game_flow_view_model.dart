import 'package:flutter/material.dart';
import 'package:mvp_game/core/enum/game_level.dart';
import 'package:mvp_game/core/enum/game_type.dart';

class GameFlowViewModel extends ChangeNotifier {
  GameType? _selectedType;
  GameLevel? _selectedLevel;

  GameType? get selectedType => _selectedType;
  GameLevel? get selectedLevel => _selectedLevel;

  void selectType(GameType type) {
    _selectedType = type;
    notifyListeners();
  }

  void selectLevel(GameLevel level) {
    _selectedLevel = level;
    notifyListeners();
  }
}
