import 'package:archeland_encyclopedia/src/common_widgets/alert_dialogs.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart';
import 'package:archeland_encyclopedia/src/localization/string_hardcoded.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignOutButtonWidget extends ConsumerWidget {
  const SignOutButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      signInScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(signInScreenControllerProvider);

    return ElevatedButton(
      onPressed: state.isLoading
          ? null
          : () async {
              final logout = await showAlertDialog(
                context: context,
                title: '알림'.hardcoded,
                content: '로그아웃 하시겠습니까?',
                cancelActionText: '취소'.hardcoded,
                defaultActionText: '확인'.hardcoded,
              );
              if (logout == true) {
                ref.read(signInScreenControllerProvider.notifier).signOut();
              }
            },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.logout, size: 20),
          const SizedBox(width: 16),
          Text(
            '로그아웃'.hardcoded,
          ),
        ],
      ),
    );
  }
}
