import 'dart:core';

import 'package:archeland_encyclopedia/src/database/firebase/firestore_data_source.dart';
import 'package:archeland_encyclopedia/src/features/authentication/domain/app_user.dart';
import 'package:archeland_encyclopedia/src/features/characters/domain/character.dart';
import 'package:archeland_encyclopedia/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'characters_firestore_repository.g.dart';

class CharactersRepository {
  CharactersRepository(this._dataSource);
  final inMemoryStore = InMemoryStore<List<Character>?>(null);
  final FirestoreDataSource _dataSource;

  Future<void> setCharacter(
          {required UserId uid, required Character character}) =>
      _dataSource.setData(
          path: FirestorePath.character(character.id),
          data: character.toJson());

  Stream<Character> watchCharacter({required CharacterId id}) =>
      _dataSource.watchDocument(
        path: FirestorePath.character(id),
        builder: (data, documentId) => Character.fromJson(data!),
      );

  Stream<List<Character>> watchCharacters() {
    final data = _dataSource.watchCollection(
      path: FirestorePath.characters(),
      builder: (data, documentId) => Character.fromJson(data!),
    );
    return data;
  }

  Future<List<Character>> fetchCharacters() async {
    inMemoryStore.value ??= await _dataSource.fetchCollection(
      path: FirestorePath.characters(),
      builder: (data, documentId) => Character.fromJson(data!),
    );
    return Future.value(inMemoryStore.value);
  }

  Future<List<Character>> searchCharacters(String query) async {
    final charactersList = await fetchCharacters();
    var result = <Character>[];
    result.addAll(
        charactersList.where((character) => character.name.contains(query)));
    result.addAll(charactersList.where((character) =>
        character.uniqueSkill != null && character.uniqueSkill?.name != null
            ? character.uniqueSkill!.name!.contains(query)
            : false));
    result.addAll(charactersList.where((character) =>
        character.uniqueSkill != null &&
                character.uniqueSkill?.description != null
            ? character.uniqueSkill!.description!.contains(query)
            : false));
    result.addAll(charactersList.where((character) => character.element != null
        ? character.element!.contains(query)
        : false));

    return result.toSet().toList();
  }
}

@riverpod
CharactersRepository charactersRepository(CharactersRepositoryRef ref) {
  return CharactersRepository(ref.watch(firestoreDataSourceProvider));
}

@riverpod
Future<List<Character>> charactersListSearch(
    CharactersListSearchRef ref, String query) async {
  final repository = ref.watch(charactersRepositoryProvider);
  return repository.searchCharacters(query);
}

final charactersStreamProvider =
    StreamProvider.autoDispose<List<Character>>((ref) {
  return ref.watch(charactersRepositoryProvider).watchCharacters();
});

final characterStreamProvider = StreamProvider.autoDispose
    .family<Character, CharacterId>((ref, characterId) {
  final database = ref.watch(charactersRepositoryProvider);
  return database.watchCharacter(id: characterId);
});
