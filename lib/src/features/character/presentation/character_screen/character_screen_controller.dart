import 'package:archeland_encyclopedia/src/features/character/data/character_repository.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_screen_controller.g.dart';

@riverpod
class CharacterScreenController extends _$CharacterScreenController {
  @override
  Future<Character> build(CharacterId id) async {
    final stream = ref.watch(characterStreamProvider(id));
    return Future.value(stream.value);
  }

  AsyncValue<Character> watchCharacter() {
    final stream = ref.watch(characterStreamProvider(id));
    return stream;
  }

  Future submitSkillForm() {
    // final character = ref.watch(characterRepositoryProvider);
    return Future.value();
  }
}
