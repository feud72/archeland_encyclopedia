import 'dart:async';

import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_in_screen_controller.g.dart';

@riverpod
class SignInScreenController extends _$SignInScreenController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  User? get user => ref.watch(authRepositoryProvider).currentUser;

  Future<void> signInWithCredential() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signInWithGoogle);
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    final authRepository = ref.read(authRepositoryProvider);
    state = await AsyncValue.guard(authRepository.signOut);
  }
}
