import 'dart:async';

import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:archeland_encyclopedia/src/features/authentication/domain/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_screen_controller.g.dart';

@riverpod
class AccountScreenController extends _$AccountScreenController {
  final accountFirestorePath = '/accounts';

  @override
  FutureOr<AppUser?> build() async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    return await authRepository.fetchAppUser();
    //
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(() async {
      await authRepository.signOut();
      return Future.value(null);
    });
  }

  Future<bool> submitAccount(
      {required String username, required String server}) async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    final result = await authRepository.setAccount(server, username);
    state = await AsyncValue.guard(() => Future.value(null));
    return result;
  }
}
