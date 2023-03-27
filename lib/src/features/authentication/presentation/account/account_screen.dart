import 'package:archeland_encyclopedia/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/account/page/account_form_page.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/account/page/account_page.dart';
import 'package:archeland_encyclopedia/src/localization/string_hardcoded.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(accountScreenControllerProvider);
    // ref.read(authRepositoryProvider).signOut();

    return Scaffold(
        appBar: AppBar(
          title: Text('나의 계정'.hardcoded,
              style: Theme.of(context).textTheme.titleLarge),
        ),
        body: state.when(
            data: (data) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: data != null
                        ? const AccountPage()
                        : const AccountFormPage(),
                  ),
                ),
            error: (error, stackTrace) => Center(
                  child: Column(
                    children: [
                      Text(error.toString()),
                      Text(stackTrace.toString()),
                    ],
                  ),
                ),
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }
}
