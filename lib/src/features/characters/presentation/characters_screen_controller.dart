import 'dart:async';

import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/characters/data/characters_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'characters_screen_controller.g.dart';

@riverpod
class CharactersScreenController extends _$CharactersScreenController {
  @override
  FutureOr<List<Character>> build() async {
    return [];
  }

  Future<List<Character>> fetchCharacters() {
    return ref.read(charactersRemoteRepositoryProvider).fetchCharacters();
  }
}
