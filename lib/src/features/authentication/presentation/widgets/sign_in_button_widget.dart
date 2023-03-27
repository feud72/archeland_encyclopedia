import 'package:archeland_encyclopedia/src/constants/keys.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInButtonWidget extends ConsumerWidget {
  const SignInButtonWidget({Key? key}) : super(key: key);

  static const Key emailPasswordButtonKey = Key(Keys.emailPassword);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      signInScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(signInScreenControllerProvider);
    return ElevatedButton(
      key: emailPasswordButtonKey,
      onPressed: state.isLoading
          ? null
          : () async {
              await ref
                  .read(signInScreenControllerProvider.notifier)
                  .signInWithCredential();
            },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/google/google-logo.png',
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 16),
          const Text("구글 아이디로 로그인"),
        ],
      ),
    );
  }
}
