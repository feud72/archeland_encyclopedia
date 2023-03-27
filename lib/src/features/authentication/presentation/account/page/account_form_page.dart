import 'package:archeland_encyclopedia/src/features/authentication/domain/app_user.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:archeland_encyclopedia/src/routing/app_router.dart';
import 'package:archeland_encyclopedia/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AccountFormPage extends ConsumerStatefulWidget {
  const AccountFormPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountFormPage> createState() =>
      _EditBasicInfoFormWidgetState();
}

class _EditBasicInfoFormWidgetState extends ConsumerState<AccountFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? username;
  String? server;

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      final success = await ref
          .read(accountScreenControllerProvider.notifier)
          .submitAccount(username: username!, server: server!);
      if (success is AppUser && mounted) {
        context.goNamed(AppRoute.account.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(accountScreenControllerProvider);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '서버',
                prefixIcon: Icon(Icons.home_filled),
              ),
              maxLines: 1,
              validator: (value) => textFieldNotNullAndNotEmptyValidator(value),
              keyboardAppearance: Brightness.light,
              onChanged: (String? value) => setState(() => server = value),
            ),
            _divider(),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '닉네임',
                prefixIcon: Icon(Icons.home_filled),
              ),
              maxLines: 1,
              validator: (value) => textFieldNotNullAndNotEmptyValidator(value),
              keyboardAppearance: Brightness.light,
              onChanged: (String? value) => setState(() => username = value),
            ),
            _divider(),
            ElevatedButton(
              onPressed: state.isLoading ? null : _submit,
              child: const Text("제출"),
            ),
            _divider(),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const SizedBox(height: 16);
  }
}
