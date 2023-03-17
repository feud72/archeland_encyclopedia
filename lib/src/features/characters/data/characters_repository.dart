import 'dart:core';

import 'package:archeland_encyclopedia/src/database/firebase/firestore_data_source.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/domain/weapon.dart';
import 'package:archeland_encyclopedia/src/features/authentication/domain/app_user.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/skill.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/special_skill.dart';
import 'package:archeland_encyclopedia/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'characters_repository.g.dart';

class CharactersRepository {
  CharactersRepository(this._dataSource);
  final characters = InMemoryStore<List<Character>?>(null);
  final character = InMemoryStore<Character?>(null);

  final FirestoreDataSource _dataSource;

  Future<void> setCharacter(
      {required UserId uid, required Character character}) async {
    await _dataSource.setData(
        path: FirestorePath.character(character.id), data: character.toJson());
    characters.value = await _dataSource.fetchCollection(
      path: FirestorePath.characters(),
      builder: (data, documentId) => Character.fromJson(data!),
    );
    return Future.value(null);
  }

  Stream<Character> watchCharacter({required CharacterId id}) {
    return InMemoryStore<Character>(
            characters.value!.singleWhere((character) => character.id == id))
        .stream;
  }
  // =>
  // _dataSource.watchDocument(
  //   path: FirestorePath.character(id),
  //   builder: (data, documentId) => Character.fromJson(data!),
  // );

  Stream<List<Character>> watchCharacters() {
    return _dataSource.watchCollection(
      path: FirestorePath.characters(),
      builder: (data, documentId) => Character.fromJson(data!),
    );
  }

  Future<List<Character>> fetchCharacters() async {
    characters.value ??= await _dataSource.fetchCollection(
      path: FirestorePath.characters(),
      builder: (data, documentId) => Character.fromJson(data!),
    );
    return Future.value(characters.value);
  }

  bool _checkPropertyExistAndContain(String? property, String query) {
    return property != null && property.contains(query);
  }

  bool _searchSpecialSkillQuery(SpecialSkill? skill, String query) {
    if (skill == null) return false;
    return _checkPropertyExistAndContain(skill.name, query) ||
        _checkPropertyExistAndContain(skill.description, query);
  }

  bool _searchSkillQuery(Skill? skill, String query) {
    if (skill == null) return false;
    return _checkPropertyExistAndContain(skill.name, query) ||
        _checkPropertyExistAndContain(skill.description, query);
  }

  bool _searchWeaponQuery(Weapon? weapon, String query) {
    if (weapon == null) return false;
    return _checkPropertyExistAndContain(weapon.name, query) ||
        _checkPropertyExistAndContain(weapon.effectName, query) ||
        _checkPropertyExistAndContain(weapon.effectDescription, query) ||
        _checkPropertyExistAndContain(weapon.uniqueEffectName, query) ||
        _checkPropertyExistAndContain(weapon.uniqueEffectDescription, query);
  }

  Future<List<Character>> searchCharacters(String query) async {
    final charactersList = await fetchCharacters();
    return charactersList
        .where(
          (character) =>
              _checkPropertyExistAndContain(character.name, query) ||
              _searchSpecialSkillQuery(character.uniqueSkill, query) ||
              _searchSpecialSkillQuery(character.leaderSkill, query) ||
              _searchSkillQuery(character.baseSkill, query) ||
              _searchSkillQuery(character.ultimate, query) ||
              _searchSkillQuery(character.upperFirst, query) ||
              _searchSkillQuery(character.upperSecond, query) ||
              _searchSkillQuery(character.middleFirst, query) ||
              _searchSkillQuery(character.middleSecond, query) ||
              _searchSkillQuery(character.lowerFirst, query) ||
              _searchSkillQuery(character.lowerSecond, query) ||
              _searchWeaponQuery(character.weapon, query) ||
              _checkPropertyExistAndContain(character.element, query),
        )
        .toList();
  }
}

@riverpod
CharactersRepository charactersRemoteRepository(
    CharactersRemoteRepositoryRef ref) {
  return CharactersRepository(ref.watch(firestoreDataSourceProvider));
}

@riverpod
Future<List<Character>> charactersListSearch(
    CharactersListSearchRef ref, String query) async {
  final repository = ref.watch(charactersRemoteRepositoryProvider);
  return repository.searchCharacters(query);
}
//
// final characterStreamProvider = StreamProvider.autoDispose
//     .family<Character, CharacterId>((ref, characterId) {
//   final database = ref.watch(charactersRemoteRepositoryProvider);
//   return database.watchCharacter(id: characterId);
// });
