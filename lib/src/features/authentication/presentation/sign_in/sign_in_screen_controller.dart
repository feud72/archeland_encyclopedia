import 'dart:async';

import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreenController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<void> signInAnonymously() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signInAnonymously);
  }

  Future<void> signInWithCredential() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signInWithGoogle);
  }
}

final signInScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<SignInScreenController, void>(
        SignInScreenController.new);
