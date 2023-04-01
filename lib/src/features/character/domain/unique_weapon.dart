import 'package:freezed_annotation/freezed_annotation.dart';

part 'unique_weapon.freezed.dart';
part 'unique_weapon.g.dart';

@freezed
class UniqueWeapon with _$UniqueWeapon {
  const factory UniqueWeapon({
    required String name,
    String? subName,
    required String weaponType,
    required String effectName,
    required String effectDescription,
    String? uniqueEffectName,
    String? uniqueEffectDescription,
  }) = _UniqueWeapon;

  factory UniqueWeapon.fromJson(Map<String, dynamic> json) =>
      _$UniqueWeaponFromJson(json);
}
