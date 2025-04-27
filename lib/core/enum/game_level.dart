enum GameLevel {
  three(3),
  four(4),
  five(5);

  final int size;
  const GameLevel(this.size);

  static final Map<int, GameLevel> _valueMqp = {
    for (final level in GameLevel.values) level.size: level,
  };

  static GameLevel parse(int size) {
    return _valueMqp[size] ?? GameLevel.three;
  }

  int get totalCount => size * size;
}
