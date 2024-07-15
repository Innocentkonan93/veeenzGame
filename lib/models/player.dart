import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String id;
  final String name;
  final int position;
  final int powers;

  const Player({
    required this.id,
    required this.name,
    required this.position,
    required this.powers,
  });

  Player copyWith({String? id, String? name, int? position, int? powers}) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      powers: powers ?? this.powers,
    );
  }

  @override
  List<Object> get props => [id, name, position, powers];

  static List<Player> players = [
    const Player(
      id: "1",
      name: "Josco",
      position: 1,
      powers: 1,
    ),
  ];

  Player decrementPower() {
    return copyWith(powers: powers > 0 ? powers - 1 : 0);
  }
}
