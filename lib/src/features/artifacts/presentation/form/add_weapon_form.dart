import 'package:flutter/material.dart';

class AddWeaponForm extends StatefulWidget {
  const AddWeaponForm({Key? key}) : super(key: key);

  @override
  State<AddWeaponForm> createState() => _AddWeaponFormState();
}

class _AddWeaponFormState extends State<AddWeaponForm> {
  late String? name;
  late String? weaponType;
  String? effectName;
  String? effectDescription;
  String? uniqueEffectName;
  String? uniqueEffectDescription;

  final _formKey = GlobalKey<FormState>();

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
      // final success = await ref
      //     .read(characterScreenControllerProvider.notifier)
      //     .submitWeapon(
      //   character: widget.character!,
      //   name: name!,
      //   weaponType: weaponType!,
      //   effectName: effectName!,
      //   effectDescription: effectDescription!,
      //   uniqueEffectName: uniqueEffectName!,
      //   uniqueEffectDescription: uniqueEffectDescription!,
      // );
      // if (success && mounted) {
      //   context.pop();
      // }
    }
  }

  Widget _divider() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
