import 'package:archeland_encyclopedia/src/features/artifacts/domain/weapon.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/skill.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/special_skill.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'character.freezed.dart';
part 'character.g.dart';

typedef CharacterId = String;

@freezed
class Character with _$Character {
  const factory Character({
    required String id,
    required String name,
    String? gender,
    String? rank,
    String? job,
    String? element,
    String? weaponType,
    SpecialSkill? uniqueSkill,
    bool? isLeader,
    SpecialSkill? leaderSkill,
    List<Skill?>? skill,
    Weapon? weapon,
    String? hp,
    String? pAtk,
    String? mAtk,
    String? pDef,
    String? mDef,
    String? concentration,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}
