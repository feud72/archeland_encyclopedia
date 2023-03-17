import 'dart:async';

import 'package:archeland_encyclopedia/src/database/firebase/firestore_data_source.dart';
import 'package:archeland_encyclopedia/src/exceptions/character_submit_exception.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/special_skill.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/edit_character_screen/edit_character_status_provider.dart';
import 'package:archeland_encyclopedia/src/features/characters/data/characters_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_character_screen_controller.g.dart';

@riverpod
class EditCharacterScreenController extends _$EditCharacterScreenController {
  @override
  FutureOr<void> build() {
    //
  }

  bool fillBasicInfo({
    required String name,
    String? rank,
    String? job,
    String? element,
    String? weaponType,
  }) {
    try {
      final character = ref.read(newCharacterProvider);
      final notifier = ref.read(newCharacterProvider.notifier);
      notifier.state = character.copyWith(
          name: name,
          rank: rank,
          job: job,
          element: element,
          weaponType: weaponType);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool fillStatus(
      int? hp, int? pAtk, int? pDef, int? mAtk, int? mDef, int? concentration) {
    try {
      final character = ref.read(newCharacterProvider);
      final notifier = ref.read(newCharacterProvider.notifier);
      notifier.state = character.copyWith(
        hp: hp?.toString(),
        pAtk: pAtk?.toString(),
        pDef: pDef?.toString(),
        mAtk: mAtk?.toString(),
        mDef: mDef?.toString(),
        concentration: concentration?.toString(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> submit({
    required CharacterStatus characterStatus,
  }) async {
    state = const AsyncLoading().copyWithPrevious(state);
    // final currentUser = ref.read(authRepositoryProvider).currentUser;
    // if (currentUser == null
    //     // || currentUser.isAnonymous
    //     ) {
    //   state = AsyncError(AnonymousUserException(), StackTrace.current);
    //   return false;
    // }
    final database = ref.read(charactersRemoteRepositoryProvider);
    final characters = await database.fetchCharacters();
    final allNames = characters.map((character) => character.name).toList();
    // if (character != null) {
    //   allNames.remove(character.name);
    // }
    if (allNames.contains(characterStatus.name)) {
      state = AsyncError(CharacterSameNameException(), StackTrace.current);
      return false;
    } else {
      // final id = character?.id ?? documentIdFromCurrentDate();
      final id = documentIdFromCurrentDate();
      final updated = Character(
        id: id,
        name: characterStatus.name!,
        rank: characterStatus.rank,
        job: characterStatus.job,
        element: characterStatus.element,
        weaponType: characterStatus.weaponType,
        hp: characterStatus.hp,
        pAtk: characterStatus.pAtk,
        mAtk: characterStatus.mAtk,
        pDef: characterStatus.pDef,
        mDef: characterStatus.mDef,
        concentration: characterStatus.concentration,
        uniqueSkill: characterStatus.uniqueSkillName != null
            ? SpecialSkill(
                name: characterStatus.uniqueSkillName,
                description: characterStatus.uniqueSkillDescription)
            : null,
        leaderSkill: characterStatus.leaderSkillName != null &&
                characterStatus.leaderSkillName!.isNotEmpty
            ? SpecialSkill(
                name: characterStatus.leaderSkillName,
                description: characterStatus.leaderSkillDescription)
            : null,
      );

      state = await AsyncValue.guard(
        // () => database.setCharacter(character: updated, uid: currentUser.uid),
        () => database.setCharacter(character: updated, uid: ""),
      );
      return state.hasError == false;
    }
  }
}
