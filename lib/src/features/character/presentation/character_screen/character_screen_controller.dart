import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:archeland_encyclopedia/src/features/character/data/character_repository.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/skill.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/unique_weapon.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_screen_controller.g.dart';

@riverpod
class CharacterScreenController extends _$CharacterScreenController {
  @override
  FutureOr<void> build() async {}

  Stream<Character> characterStream(CharacterId characterId) {
    final repository = ref.read(characterRepositoryProvider);
    return repository.watchCharacter(characterId: characterId);
  }

  Future submitSkillForm({
    required Character character,
    required String name,
    required String type,
    required String coolTime,
    required int cost,
    required String range,
    required String radius,
    required String description,
    required String position,
  }) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      final uid = user.uid;
      final skill = Skill(
          name: name,
          description: description,
          cost: cost,
          coolTime: coolTime,
          type: type,
          range: range,
          radius: radius,
          position: position);
      final isDuplicated = character.skill
          ?.any((element) => element?.position == skill.position);
      final skillList =
          character.skill != null ? [...character.skill!] : <Skill>[];
      if (isDuplicated != null && isDuplicated) {
        skillList.removeWhere((element) => element!.position == skill.position);
      }
      skillList.add(skill);
      final updated = character.copyWith(skill: skillList);
      state = await AsyncValue.guard(() => ref
          .read(characterRepositoryProvider)
          .updateCharacter(uid: uid, character: updated));
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<bool> submitWeapon({
    required String name,
    required Character character,
    required String weaponType,
    required String effectName,
    required String effectDescription,
    required String uniqueEffectName,
    required String uniqueEffectDescription,
  }) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      final uid = user.uid;
      final weapon = UniqueWeapon(
        name: name,
        weaponType: weaponType,
        effectName: effectName,
        effectDescription: effectDescription,
        uniqueEffectDescription: uniqueEffectDescription,
        uniqueEffectName: uniqueEffectName,
      );
      final updated = character.copyWith(weapon: weapon);
      state = await AsyncValue.guard(() => ref
          .read(characterRepositoryProvider)
          .updateCharacter(uid: uid, character: updated));
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}

@riverpod
Stream<Character> characterStream(
    CharacterStreamRef ref, CharacterId characterId) {
  return ref
      .watch(characterScreenControllerProvider.notifier)
      .characterStream(characterId);
}
