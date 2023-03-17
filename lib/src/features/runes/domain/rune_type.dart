import 'package:freezed_annotation/freezed_annotation.dart';

part 'rune_type.freezed.dart';
part 'rune_type.g.dart';

@freezed
class RuneType with _$RuneType {
  const factory RuneType({
    required List<String> firstStatus,
    List<String>? secondStatus,
    required List<String> attackOption,
    required List<String> defensiveOption,
    required int attackOptionMax,
    required int defensiveOptionMax,
  }) = _RuneType;

  factory RuneType.fromJson(Map<String, dynamic> json) =>
      _$RuneTypeFromJson(json);
}
