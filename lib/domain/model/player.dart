import 'package:smash_flutter/domain/model/player_dto.dart';

class Player {
  final String id;
  final String name;
  final List<int> cards;
  final bool isMe;
  final bool turnEnabled;

  Player(this.id, this.name, this.cards, this.isMe, this.turnEnabled);

  static fromDto(PlayerDTO dto) {
    return Player(dto.id!, dto.name!, dto.cards!, dto.isMe!, dto.turnEnabled!);
  }
}