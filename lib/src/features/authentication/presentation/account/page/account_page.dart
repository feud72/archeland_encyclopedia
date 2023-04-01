import 'package:archeland_encyclopedia/src/common_widgets/alert_dialogs.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:archeland_encyclopedia/src/localization/string_hardcoded.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountPage extends ConsumerStatefulWidget {
  const AccountPage({super.key});

  @override
  ConsumerState<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends ConsumerState<AccountPage> {
  final TextEditingController nicknameEditingController =
      TextEditingController();
  final TextEditingController serverEditingController = TextEditingController();

  late String username;
  late String server;
  bool isNicknameEditingMode = false;
  bool isServerEditingMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nicknameEditingController.dispose();
    serverEditingController.dispose();
    super.dispose();
  }

  void _handleServerSubmitted(String value) async {
    setState(() {
      isServerEditingMode = false;
      server = value;
    });
  }

  void _handleNicknameSubmitted(value) async {
    setState(() {
      isNicknameEditingMode = false;
      username = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(accountScreenControllerProvider);
    final user = state.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (user != null) ...[
          ElevatedButton(
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
                      ref
                          .read(accountScreenControllerProvider.notifier)
                          .signOut();
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
          ),
          const SizedBox(height: 16),
          isServerEditingMode || server.isEmpty
              ? ValueListenableBuilder(
                  valueListenable: serverEditingController,
                  builder: (context, value, _) => TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: '서버',
                      prefixIcon: const Icon(Icons.home_filled),
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: value.text.isNotEmpty
                            ? [
                                TextButton(
                                  onPressed: () => _handleServerSubmitted(
                                      serverEditingController.text),
                                  child: const Text("저장"),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      serverEditingController.clear(),
                                  icon: const Icon(Icons.clear),
                                )
                              ]
                            : [],
                      ),
                    ),
                    onSubmitted: _handleServerSubmitted,
                    maxLines: 1,
                    controller: serverEditingController,
                    keyboardAppearance: Brightness.light,
                  ),
                )
              : ListTile(
                  leading: const Icon(Icons.home_filled),
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(server),
                  trailing: IconButton(
                      onPressed: () =>
                          setState(() => isServerEditingMode = true),
                      icon: const Icon(Icons.edit_note)),
                ),
          const SizedBox(height: 16),
          isNicknameEditingMode || username.isEmpty
              ? ValueListenableBuilder(
                  builder: (context, value, _) => TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: '닉네임',
                      prefixIcon: const Icon(Icons.person),
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: value.text.isNotEmpty
                            ? [
                                TextButton(
                                    child: const Text('저장'),
                                    onPressed: () => _handleNicknameSubmitted(
                                        nicknameEditingController.text)),
                                IconButton(
                                  onPressed: () {
                                    nicknameEditingController.clear();
                                  },
                                  icon: const Icon(Icons.clear),
                                )
                              ]
                            : [],
                      ),
                    ),
                    onSubmitted: _handleNicknameSubmitted,
                    maxLines: 1,
                    controller: nicknameEditingController,
                    keyboardAppearance: Brightness.light,
                  ),
                  valueListenable: nicknameEditingController,
                )
              : ListTile(
                  leading: const Icon(Icons.person),
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(username),
                  trailing: IconButton(
                      onPressed: () =>
                          setState(() => isNicknameEditingMode = true),
                      icon: const Icon(Icons.edit_note)),
                ),
        ],
      ],
    );
  }
}
