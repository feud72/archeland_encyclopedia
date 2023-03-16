import 'package:freezed_annotation/freezed_annotation.dart';

part 'special_skill.freezed.dart';
part 'special_skill.g.dart';

@freezed
class SpecialSkill with _$SpecialSkill {
  const factory SpecialSkill({
    required String? name,
    required String? description,
  }) = _SpecialSkill;

  factory SpecialSkill.fromJson(Map<String, dynamic> json) =>
      _$SpecialSkillFromJson(json);
}
