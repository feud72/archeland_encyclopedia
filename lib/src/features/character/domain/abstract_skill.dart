//
// part 'abstract_skill.freezed.dart';
// part 'abstract_skill.g.dart';

// @freezed
// abstract class AbstractSkill with _$AbstractSkill {
//   const factory AbstractSkill({
//     required String? name,
//     required String? description,
//   }) = _AbstractSkill;
//
//   factory AbstractSkill.fromJson(Map<String, dynamic> json) =>
//       _$AbstractSkillFromJson(json);
// }

abstract class AbstractSkill {
  String? get name;
  String? get description;
}
