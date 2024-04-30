import 'package:json_annotation/json_annotation.dart';
import 'package:smash_flutter/domain/model/player.dart';

part 'player_dto.g.dart';

@JsonSerializable()
class PlayerDTO {
  final String? id;
  final String? name;
  final List<int>? cards;
  final bool? isMe;
  final bool? turnEnabled;

  PlayerDTO(this.id, this.name, this.cards, this.isMe, this.turnEnabled);

  factory PlayerDTO.fromJson(Map<String, dynamic> json) => _$PlayerDTOFromJson(json);

  factory PlayerDTO.fromPlayer(Player player) =>
      PlayerDTO(player.id, player.name, player.cards, player.isMe, player.turnEnabled);

  Map<String, dynamic> toJson() => _$PlayerDTOToJson(this);
}
