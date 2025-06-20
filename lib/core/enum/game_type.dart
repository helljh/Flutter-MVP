enum GameType {
  number('숫자'),
  color('색상'),
  direction('방향');

  final String label;

  const GameType(this.label);
}
