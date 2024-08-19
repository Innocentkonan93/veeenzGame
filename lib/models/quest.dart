import 'dart:convert';

import 'package:veeenz/utils/constants.dart';

enum QuestType {
  catchRunner,
  reachLevel,
  timeChallenge
  // Ajoute d'autres types si nécessaire
}

class Quest {
  final String id;
  final String title;
  final String description;
  final QuestType type; // Utilisation de l'énumération
  final int goal;
  final List<int> rewards;
  int progress;

  Quest({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.goal,
    required this.rewards,
    this.progress = 0,
  });

  Quest copyWith({
    String? id,
    String? title,
    String? description,
    QuestType? type,
    int? goal,
    List<int>? rewards,
    int? progress,
  }) {
    return Quest(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      goal: goal ?? this.goal,
      rewards: rewards ?? this.rewards,
      progress: progress ?? this.progress,
    );
  }

  factory Quest.fromMap(Map<String, dynamic> map) {
    // Conversion de String vers QuestType
    QuestType questType = QuestType.values.firstWhere(
      (e) => e.toString().split('.').last == map['type'],
      orElse: () => throw Exception('Invalid quest type: ${map['type']}'),
    );

    return Quest(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      type: questType,
      goal: map['goal'],
      rewards: List<int>.from(map['rewards']),
      progress: map['progress'] ?? 0,
    );
  }

  // Si besoin, tu peux ajouter une méthode pour convertir l'instance en Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last, // Conversion du type en String
      'goal': goal,
      'rewards': rewards,
      'progress': progress,
    };
  }

  bool get isCompleted => progress >= goal;

  String toJson() => json.encode(toMap());

  bool updateProgress(String questId, int progressIncrease) {
    for (var quest in allGameQuests) {
      if (quest.id == questId) {
        int previousProgress = quest.progress;
        quest.progress += progressIncrease;

        if (quest.progress > previousProgress) {
          print('Progress made in quest "${quest.title}".');
          return true; // Progress was made
        } else {
          print('No progress made in quest "${quest.title}".');
          return false; // No progress
        }
      }
    }
    return false; // If the quest was not found
  }

  factory Quest.fromJson(String source) => Quest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Quest(id: $id, title: $title, description: $description, type: $type, goal: $goal, rewards: $rewards, progress: $progress)';
  }
}
