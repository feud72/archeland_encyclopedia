import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

part 'sembast_repository.g.dart';

class LocalRepository {
  LocalRepository(this.database);
  final Database database;

  static Future<Database> createDatabase(String filename) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    return databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
  }

  static Future<LocalRepository> makeDefault() async {
    return LocalRepository(await (createDatabase('archeland.db')));
  }
}

@Riverpod(keepAlive: true)
LocalRepository localRepository(LocalRepositoryRef ref) =>
    throw UnimplementedError();
