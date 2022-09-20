import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String id;
  final String name;
  final int position;

  const Player({
    required this.id,
    required this.name,
    required this.position,
  });

  Player copyWith({String? id, String? name, int? position}) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
    );
  }

  @override
  List<Object> get props => [id, name, position];

  static List<Player> players = [
    const Player(id: "1", name: "Josco", position: 1),
  ];
}
