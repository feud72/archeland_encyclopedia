import 'package:archeland_encyclopedia/src/database/firebase/firestore_data_source.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_character_status_provider.g.dart';

class CharacterStatus {
  String? name;
  String? job;
  String? element;
  String? rank;
  String? weaponType;
  String? uniqueSkillName;
  String? uniqueSkillDescription;
  String? hp;
  String? pAtk;
  String? mAtk;
  String? pDef;
  String? mDef;
  String? concentration;
}

// Todo: 나중에 건드려 보자. 너무 어렵다
final characterStatusStateProvider =
    StateProvider<CharacterStatus>((ref) => CharacterStatus());

@riverpod
characterStatus(CharacterStatusRef ref) {
  return ref.watch(characterStatusStateProvider);
}

final newCharacterProvider = StateProvider<Character>(
    (ref) => Character(id: documentIdFromCurrentDate(), name: ''));
