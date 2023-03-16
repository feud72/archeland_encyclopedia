import 'package:freezed_annotation/freezed_annotation.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill with _$Skill {
  const factory Skill({
    required String name,
    required String description,
    required int level,
    required int cost,
    required String type,
    required String coolTime,
    required String range,
    required String damageRadius,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
