import 'package:archeland_encyclopedia/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/widgets/notification_widget.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/widgets/sign_in_button_widget.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/widgets/sign_out_button_widget.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      signInScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(signInScreenControllerProvider);
    final user = ref.watch(signInScreenControllerProvider.notifier).user;
    return Scaffold(
      appBar: AppBar(
        title: user != null
            ? Text('${user.displayName} 님, 반갑습니다.')
            : const Text("로그인"),
      ),
      body: Container(
        foregroundDecoration: state.isLoading
            ? BoxDecoration(color: Colors.grey.withAlpha(50))
            : null,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const NotificationWidget(),
            const SizedBox(height: 16),
            user == null
                ? const SignInButtonWidget()
                : const SignOutButtonWidget(),
          ],
        ),
      ),
    );
  }
}
