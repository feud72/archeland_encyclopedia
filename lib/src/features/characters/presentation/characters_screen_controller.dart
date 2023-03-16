import 'dart:async';

import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/characters/application/characters_service.dart';
import 'package:archeland_encyclopedia/src/features/characters/data/characters_repository.dart';
import 'package:archeland_encyclopedia/src/features/characters/data/characters_sembast_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'characters_screen_controller.g.dart';

@riverpod
class CharactersScreenController extends _$CharactersScreenController {
  @override
  FutureOr<List<Character>> build() async {
    // state = const AsyncLoading();
    // final data = fetchCharacters();
    // state = await AsyncValue.guard(() => data);
    // return data;
    return [];
  }

  CharactersService get charactersService =>
      ref.read(charactersServiceProvider);

  Future<List<Character>> fetchCharacters() {
    return ref.read(charactersRemoteRepositoryProvider).fetchCharacters();
  }

  Stream<List<Character>> watchCharacters() {
    charactersService.addCharacters();
    return ref.watch(charactersLocalRepositoryProvider).getAllCharacterStream();
  }

  Future<void> orderByName() async {
    // state = const AsyncLoading().copyWithPrevious(state);
    // final database = ref.read(databaseProvider);
    // final heroes = await database.fetchHeroes();
  }
}
