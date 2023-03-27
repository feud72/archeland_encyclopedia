import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AskingEditingListTile extends ConsumerWidget {
  const AskingEditingListTile(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.subtitle})
      : super(key: key);

  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authRepositoryProvider).currentUser;
    return ListTile(
      onTap: user != null ? onTap : null,
      title: Text(title),
      subtitle: Text(user != null ? subtitle : "로그인 후 작성할 수 있습니다."),
      trailing: user != null ? const Icon(Icons.edit_note) : null,
    );
  }
}
