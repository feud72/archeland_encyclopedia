import 'package:freezed_annotation/freezed_annotation.dart';

part 'weapon.freezed.dart';
part 'weapon.g.dart';

@freezed
class Weapon with _$Weapon {
  const factory Weapon({
    required String name,
    String? subName,
    required String weaponType,
    required String effectName,
    required String effectDescription,
    String? uniqueEffectName,
    String? uniqueEffectDescription,
  }) = _Weapon;

  factory Weapon.fromJson(Map<String, dynamic> json) => _$WeaponFromJson(json);
}
