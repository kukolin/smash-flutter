import 'package:json_annotation/json_annotation.dart';
import 'package:smash_flutter/domain/model/player_dto.dart';

part 'room_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomDTO {
  final List<int>? cardStack;
  final String? currentTurn;
  final String? key;
  final String? name;
  final List<PlayerDTO>? players;
  final bool? started;

  RoomDTO(this.cardStack, this.currentTurn, this.key, this.name, this.players, this.started);

  factory RoomDTO.fromJson(Map<String, dynamic> json) => _$RoomDTOFromJson(json);

  Map<String, dynamic> toJson() => _$RoomDTOToJson(this);
}