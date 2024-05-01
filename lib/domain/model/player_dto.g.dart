// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerDTO _$PlayerDTOFromJson(Map<String, dynamic> json) => PlayerDTO(
      json['id'] as String?,
      json['name'] as String?,
      (json['cards'] as List<dynamic>?)?.map((e) => e as int).toList(),
      json['isOwner'] as bool?,
    );

Map<String, dynamic> _$PlayerDTOToJson(PlayerDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cards': instance.cards,
      'isOwner': instance.isOwner,
    };
