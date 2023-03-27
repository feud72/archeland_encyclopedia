import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/sign_in/sign_in_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/configs/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfigsScreen extends ConsumerWidget {
  const ConfigsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const NotificationWidget(),
              ElevatedButton(
                onPressed: user == null
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
