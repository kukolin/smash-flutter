import 'dart:core';

import 'package:smash_flutter/domain/model/player.dart';
import 'package:smash_flutter/domain/model/room_dto.dart';

class Room {
  final List<int> cardStack;
  final String currentTurn;
  final String key;
  final String name;
  final List<Player> players;
  final bool started;

  Room(this.cardStack, this.currentTurn, this.key, this.name, this.players,
      this.started);

  factory Room.empty() => Room([], "", "", "", [], false);

  static Room fromDTO(RoomDTO roomDTO) {
    return Room(
        roomDTO.cardStack ?? [],
        roomDTO.currentTurn ?? "",
        roomDTO.key ?? "",
        roomDTO.name ?? "",
        roomDTO.players?.cast<Player>() ?? [],
        roomDTO.started ?? false);
  }
}
