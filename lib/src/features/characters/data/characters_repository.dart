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
  final characters = InMemoryStore<List<Character>>([]);
  final queriedCharacters = InMemoryStore<List<Character>>([]);
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
    queriedCharacters.value = characters.value;
    return Future.value(null);
  }

  Stream<List<Character>> watchCharacters() {
    return _dataSource.watchCollection(
      path: FirestorePath.characters(),
      builder: (data, documentId) => Character.fromJson(data!),
    );
  }

  Future<List<Character>> fetchCharacters() async {
    if (characters.value.isEmpty) {
      characters.value = await _dataSource.fetchCollection(
        path: FirestorePath.characters(),
        builder: (data, documentId) => Character.fromJson(data!),
      );
    }
    return characters.value;
  }

  Future<void> makeCharacterList() async {
    final List<Character> characters = await _dataSource.fetchCollection(
      path: '/characters',
      builder: (data, documentId) => Character.fromJson(data!),
    );
    for (var character in characters) {
      final updated = character.copyWith(skill: []);
      await _dataSource.setData(
          path: 'characters/${updated.id}', data: updated.toJson());
    }
    // await _dataSource.setData(
    //     path: 'characterList/$id',
    //     data: CharacterList(id: id, characters: characters).toJson());
    // return characters;
  }

  bool _checkPropertyExistAndContain(String? property, String query) {
    return property != null && property.contains(query);
  }

  bool _searchSpecialSkillQuery(SpecialSkill? skill, String query) {
    if (skill == null) return false;
    return _checkPropertyExistAndContain(skill.name, query) ||
        _checkPropertyExistAndContain(skill.description, query);
  }

  bool _searchSkillQuery(List<Skill?>? skill, String query) {
    if (skill == null) return false;
    if (skill.isEmpty) return false;
    for (Skill? element in skill) {
      return _checkPropertyExistAndContain(element?.name, query) ||
          _checkPropertyExistAndContain(element?.description, query);
    }
    return false;
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
    final queriedCharacterList = charactersList
        .where(
          (character) =>
              _checkPropertyExistAndContain(character.name, query) ||
              _searchSpecialSkillQuery(character.uniqueSkill, query) ||
              _searchSpecialSkillQuery(character.leaderSkill, query) ||
              _searchSkillQuery(character.skill, query) ||
              _searchWeaponQuery(character.weapon, query) ||
              _checkPropertyExistAndContain(character.element, query),
        )
        .toList();
    queriedCharacters.value = queriedCharacterList;
    return queriedCharacterList;
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
