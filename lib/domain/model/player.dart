import 'package:smash_flutter/domain/model/player_dto.dart';

class Player {
  final String id;
  final String name;
  List<int> cards;
  final bool isOwner;

  Player(this.id, this.name, this.cards, this.isOwner);

  static Player fromDto(PlayerDTO dto) {
    return Player(dto.id!, dto.name!, dto.cards ?? [], dto.isOwner ?? false);
  }
}