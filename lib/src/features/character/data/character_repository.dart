import 'package:archeland_encyclopedia/src/features/authentication/domain/app_user.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_repository.g.dart';

class CharacterRepository {
  final FirebaseFirestore _firestore;

  CharacterRepository(this._firestore);

  static String characterPath(String characterId) => 'characters/$characterId';

  Future<void> updateCharacter(
          {required UserId uid, required Character character}) =>
      _firestore.doc(characterPath(character.id)).update(character.toJson());

  Stream<Character> watchCharacter({required CharacterId characterId}) =>
      _firestore
          .doc(characterPath(characterId))
          .withConverter(
            fromFirestore: (snapshot, _) =>
                Character.fromJson(snapshot.data()!),
            toFirestore: (character, _) => character.toJson(),
          )
          .snapshots()
          .map((snapshot) => snapshot.data()!);
}

@Riverpod(keepAlive: true)
CharacterRepository characterRepository(CharacterRepositoryRef ref) =>
    CharacterRepository(FirebaseFirestore.instance);

@riverpod
Stream<Character> characterStream(
    CharacterStreamRef ref, CharacterId characterId) {
  final repository = ref.watch(characterRepositoryProvider);
  return repository.watchCharacter(characterId: characterId);
}
