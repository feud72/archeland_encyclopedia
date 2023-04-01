import 'package:archeland_encyclopedia/src/database/firebase/firestore_data_source.dart';
import 'package:archeland_encyclopedia/src/features/authentication/domain/app_user.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'characters_repository.g.dart';

class CharactersRepository {
  CharactersRepository(this._dataSource);

  final FirestoreDataSource _dataSource;

  Future<void> setCharacter(
      {required UserId uid, required Character character}) async {
    await _dataSource.setData(
        path: FirestorePath.character(character.id), data: character.toJson());
    return Future.value(null);
  }

  Future<List<Character>> fetchCharacters() async {
    return await _dataSource.fetchCollection(
      path: FirestorePath.characters(),
      builder: (data, documentId) => Character.fromJson(data!),
    );
  }
}

@riverpod
CharactersRepository charactersRepository(CharactersRepositoryRef ref) {
  return CharactersRepository(ref.watch(firestoreDataSourceProvider));
}
