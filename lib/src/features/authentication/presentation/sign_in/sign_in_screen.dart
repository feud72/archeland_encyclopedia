import 'dart:math';

import 'package:archeland_encyclopedia/src/common_widgets/primary_button.dart';
import 'package:archeland_encyclopedia/src/constants/keys.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  static const Key emailPasswordButtonKey = Key(Keys.emailPassword);
  static const Key anonymousButtonKey = Key(Keys.anonymous);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      signInScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(signInScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            width: min(constraints.maxWidth, 600),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 32.0),
                // Sign in text or loading UI
                SizedBox(
                  height: 50.0,
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const Text(
                          "로그인",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 32.0, fontWeight: FontWeight.w600),
                        ),
                ),
                const SizedBox(height: 32.0),
                PrimaryButton(
                  key: emailPasswordButtonKey,
                  text: "구글 계정으로 로그인",
                  onPressed: state.isLoading
                      ? null
                      : () => ref
                          .read(signInScreenControllerProvider.notifier)
                          .signInWithCredential(),
                ),
                const SizedBox(height: 8),
                const Text(
                  "또는",
                  style: TextStyle(fontSize: 14.0, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                PrimaryButton(
                  key: anonymousButtonKey,
                  text: "비회원으로 진행",
                  onPressed: state.isLoading
                      ? null
                      : () => ref
                          .read(signInScreenControllerProvider.notifier)
                          .signInAnonymously(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
