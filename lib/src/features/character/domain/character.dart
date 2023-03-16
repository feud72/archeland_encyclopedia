import 'package:archeland_encyclopedia/src/features/characters/domain/skill.dart';
import 'package:archeland_encyclopedia/src/features/characters/domain/special_skill.dart';
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
    SpecialSkill? leaderSkill,
    Skill? baseSkill,
    Skill? middleFirst,
    Skill? middleSecond,
    Skill? ultimate,
    Skill? upperFirst,
    Skill? upperSecond,
    Skill? lowerFirst,
    Skill? lowerSecond,
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
