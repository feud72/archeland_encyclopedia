import 'package:archeland_encyclopedia/src/features/authentication/domain/app_user.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_repository.g.dart';

class CharacterRepository {
  final FirebaseFirestore _firestore;

  CharacterRepository(this._firestore);

  static String characterPath(String characterId) => 'characters/$characterId';

  Future<Character> updateCharacter(
      {required UserId uid, required Character character}) async {
    await _firestore
        .doc(characterPath(character.id))
        .update(character.toJson());
    return character;
  }

  Future<Character> fetchCharacter({required CharacterId characterId}) async {
    final reference = await _firestore.doc(characterPath(characterId)).get();
    return Character.fromJson(reference.data()!);
  }

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
