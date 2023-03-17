import 'package:archeland_encyclopedia/src/constants/color_schemes.dart';
import 'package:archeland_encyclopedia/src/constants/terms_in_game.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/edit_character_screen/edit_character_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/edit_character_screen/edit_character_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasicInfo {
  String? name;
  String? job;
  String? element;
  String? rank;
  String? weaponType;
}

class EditBasicInfoFormWidget extends ConsumerStatefulWidget {
  const EditBasicInfoFormWidget({Key? key, this.character}) : super(key: key);

  final Character? character;

  @override
  ConsumerState<EditBasicInfoFormWidget> createState() =>
      _EditBasicInfoFormWidgetState();
}

class _EditBasicInfoFormWidgetState
    extends ConsumerState<EditBasicInfoFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final BasicInfo _character = BasicInfo();

  @override
  void initState() {
    super.initState();
    final character = widget.character;
    if (character != null) {
      setState(() {
        _character.name = character.name;
        _character.rank = character.rank;
        _character.job = character.job;
        _character.element = character.element;
        _character.weaponType = character.weaponType;
      });
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _submit() {
    if (_validateAndSaveForm()) {
      final success = ref
          .read(editCharacterScreenControllerProvider.notifier)
          .fillBasicInfo(
            name: _character.name!,
            rank: _character.rank,
            job: _character.job,
            element: _character.element,
            weaponType: _character.weaponType,
          );
      if (success && mounted) {
        // context.pop();
        debugPrint(ref.read(newCharacterProvider.notifier).state.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "기본 정보",
              style: TextStyle(fontSize: 24),
            ),
            _divider(),
            TextFormField(
              initialValue: widget.character?.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '영웅 이름',
                hintText: '예) 레일라',
              ),
              keyboardAppearance: Brightness.light,
              validator: (value) =>
                  (value ?? '').isNotEmpty ? null : '이름은 반드시 입력해야 합니다.',
              onChanged: (String? name) => setState(() {
                _character.name = name;
              }),
            ),
            _divider(),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: '등급',
                border: OutlineInputBorder(),
              ),
              items: rankList
                  .map((rank) => DropdownMenuItem(
                      key: Key(rank), value: rank, child: Text(rank)))
                  .toList(),
              onChanged: (String? rank) {
                setState(() {
                  _character.rank = rank;
                });
              },
            ),
            _divider(),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: '클래스',
                border: OutlineInputBorder(),
              ),
              items: jobList
                  .map((job) => DropdownMenuItem(
                      key: Key(job), value: job, child: Text(job)))
                  .toList(),
              onChanged: (String? job) {
                setState(() {
                  _character.job = job;
                });
              },
            ),
            _divider(),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: '속성',
                border: OutlineInputBorder(),
              ),
              items: elementList
                  .map(
                    (element) => DropdownMenuItem(
                        key: Key(element),
                        value: element,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 16.0,
                              height: 16.0,
                              child: ColoredBox(
                                color: elementColor[element]!.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(element),
                          ],
                        )),
                  )
                  .toList(),
              onChanged: (String? element) {
                setState(() {
                  _character.element = element;
                });
              },
            ),
            _divider(),
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: '무기 타입',
                border: OutlineInputBorder(),
              ),
              items: weaponTypeList
                  .map((weaponType) => DropdownMenuItem(
                      key: Key(weaponType),
                      value: weaponType,
                      child: Text(weaponType)))
                  .toList(),
              onChanged: (String? weaponType) {
                setState(() {
                  _character.weaponType = weaponType;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const SizedBox(height: 16);
  }
}
