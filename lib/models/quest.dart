class Quest {
  final String id;
  final String title;
  final String description;
  final int goal;
  final int reward;
  int progress;

  Quest({
    required this.id,
    required this.title,
    required this.description,
    required this.goal,
    required this.reward,
    this.progress = 0,
  });

  bool get isCompleted => progress >= goal;
  // Convert a Quest object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'goal': goal,
      'reward': reward,
      'progress': progress,
    };
  }

  // Convert a Map object into a Quest object
  factory Quest.fromMap(Map<String, dynamic> map) {
    return Quest(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      goal: map['goal'],
      reward: map['reward'],
      progress: map['progress'],
    );
  }
}
