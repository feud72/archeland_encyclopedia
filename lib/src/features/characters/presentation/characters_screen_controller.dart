import 'package:archeland_encyclopedia/src/database/firebase/firestore_data_source.dart';
import 'package:archeland_encyclopedia/src/exceptions/character_submit_exception.dart';
import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/characters/data/characters_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'characters_screen_controller.g.dart';

@riverpod
class CharactersScreenController extends _$CharactersScreenController {
  @override
  FutureOr<void> build() async {
    return null;
  }

  Future<bool> addCharacterSubmit({
    required String name,
    required String rank,
    required String job,
    required String element,
    required String weaponType,
    required bool isLeader,
  }) async {
    state = const AsyncLoading().copyWithPrevious(state);
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    final uid = currentUser?.uid;

    final database = ref.read(charactersRepositoryProvider);
    final characters = await database.fetchCharacters();
    final allNames = characters.map((character) => character.name).toList();
    // if (character != null) {
    //   allNames.remove(character.name);
    // }
    if (allNames.contains(name)) {
      state = AsyncError(CharacterSameNameException(), StackTrace.current);
      return false;
    } else {
      final id = documentIdFromCurrentDate();
      final updated = Character(
        id: id,
        name: name,
        rank: rank,
        job: job,
        element: element,
        weaponType: weaponType,
        isLeader: isLeader,
      );
      state = await AsyncValue.guard(
        () => database.setCharacter(character: updated, uid: uid ?? ""),
      );
      return state.hasError == false;
    }
  }
}
