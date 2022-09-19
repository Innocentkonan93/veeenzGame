import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String id;
  final int position;

  const Player({
    required this.id,
    required this.position,
  });

  Player copyWith({String? id, int? position}) {
    return Player(
      id: id ?? this.id,
      position: position ?? this.position,
    );
  }

  @override
  List<Object> get props => [id, position];
}
