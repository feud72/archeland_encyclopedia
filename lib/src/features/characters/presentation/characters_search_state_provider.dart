import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/characters/data/characters_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'characters_search_state_provider.g.dart';

final charactersSearchQueryStateProvider = StateProvider<String>((ref) => '');

@riverpod
Future<List<Character>> charactersSearchResults(
    CharactersSearchResultsRef ref) {
  final searchQuery = ref.watch(charactersSearchQueryStateProvider);
  return ref.watch(charactersListSearchProvider(searchQuery).future);
}
