import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hive_repository.g.dart';

class HiveRepository {
  late Box<String> account;

  Future<void> init() async {
    account = await Hive.openBox('account');
  }
}

@riverpod
HiveRepository hiveRepository(HiveRepositoryRef ref) =>
    throw UnimplementedError();
