import 'package:equatable/equatable.dart';

class GameLevel extends Equatable {
  final String level;
  final int levelTarget;
  final String difficulty;

  const GameLevel({
    required this.level,
    required this.levelTarget,
    required this.difficulty,
  });

  GameLevel copyWith({String? level, int? levelTarget, String? difficulty}) {
    return GameLevel(
      level: level ?? this.level,
      levelTarget: levelTarget ?? this.levelTarget,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  @override
  List<Object> get props => [level, levelTarget, difficulty];
}
