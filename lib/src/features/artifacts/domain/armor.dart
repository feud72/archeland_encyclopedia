import 'package:freezed_annotation/freezed_annotation.dart';

part 'armor.freezed.dart';
part 'armor.g.dart';

@freezed
class Armor with _$Armor {
  const factory Armor({
    required String name,
    String? subName,
    required String effectName,
    required String effectDescription,
    required List<String>? jobs,
  }) = _Armor;

  factory Armor.fromJson(Map<String, dynamic> json) => _$ArmorFromJson(json);
}
