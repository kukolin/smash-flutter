import 'dart:core';

import 'package:smash_flutter/domain/model/player.dart';
import 'package:smash_flutter/domain/model/room_dto.dart';

class Room {
  List<int> cardStack;
  String currentTurn;
  String key;
  String name;
  List<Player> players;
  bool started;

  Room(this.cardStack, this.currentTurn, this.key, this.name, this.players,
      this.started);

  factory Room.empty() => Room([], "", "", "", [], false);

  static Room fromDTO(RoomDTO roomDTO) {
    return Room(
        roomDTO.cardStack ?? [],
        roomDTO.currentTurn ?? "",
        roomDTO.key ?? "",
        roomDTO.name ?? "",
        (roomDTO.players ?? []).map((e) => Player.fromDto(e)).toList(),
        roomDTO.started ?? false);
  }
}
