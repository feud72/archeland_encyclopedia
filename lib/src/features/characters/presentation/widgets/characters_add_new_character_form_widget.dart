import 'package:archeland_encyclopedia/src/constants/color_schemes.dart';
import 'package:archeland_encyclopedia/src/constants/terms_in_game.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/characters_screen_controller.dart';
import 'package:archeland_encyclopedia/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CharactersAddNewCharacterForm extends ConsumerStatefulWidget {
  const CharactersAddNewCharacterForm({Key? key, this.id, this.character})
      : super(key: key);
  final CharacterId? id;
  final Character? character;

  @override
  ConsumerState<CharactersAddNewCharacterForm> createState() =>
      _CharactersAddNewCharacterFormState();
}

class _CharactersAddNewCharacterFormState
    extends ConsumerState<CharactersAddNewCharacterForm> {
  String? name;
  String? rank;
  String? job;
  String? element;
  String? weaponType;
  bool isLeader = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.character != null) {
      name = widget.character!.name;
      rank = widget.character!.rank;
      job = widget.character!.job;
      element = widget.character!.element;
      weaponType = widget.character!.weaponType;
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

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      final success = await ref
          .read(charactersScreenControllerProvider.notifier)
          .addCharacterSubmit(
            name: name!,
            element: element!,
            job: job!,
            rank: rank!,
            weaponType: weaponType!,
            isLeader: isLeader,
          );
      if (success && mounted) {
        context.pop();
      }
    }
  }

  Widget _divider() => const SizedBox(width: 16, height: 16);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(charactersScreenControllerProvider);
    return state.isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: SizedBox(
              child: Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      right: 20,
                      left: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              "영웅 입력",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Expanded(child: SizedBox()),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () => context.pop(),
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor:
                                          ThemeData().colorScheme.onPrimary,
                                      backgroundColor: ThemeData()
                                          .colorScheme
                                          .errorContainer
                                          .withOpacity(0.8)),
                                  child: const Text("취소"),
                                ),
                                _divider(),
                                ElevatedButton(
                                  onPressed: state.isLoading ? null : _submit,
                                  child: const Text("제출"),
                                ),
                              ],
                            ),
                          ],
                        ),
                        _divider(),
                        TextFormField(
                          initialValue: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '영웅 이름',
                            hintText: '예) 레일라',
                          ),
                          keyboardAppearance: Brightness.light,
                          validator: (value) =>
                              textFieldNotNullAndNotEmptyValidator(value),
                          onSaved: (value) => name = value!,
                        ),
                        _divider(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: '등급',
                                  border: OutlineInputBorder(),
                                ),
                                items: rankList
                                    .map((rank) => DropdownMenuItem(
                                        key: Key(rank),
                                        value: rank,
                                        child: Text(rank)))
                                    .toList(),
                                validator: (value) =>
                                    textFieldNotNullAndNotEmptyValidator(value),
                                onChanged: (String? value) {
                                  setState(() {
                                    rank = value!;
                                  });
                                },
                              ),
                            ),
                            _divider(),
                            Expanded(
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  labelText: '클래스',
                                  border: OutlineInputBorder(),
                                ),
                                items: jobList
                                    .map((job) => DropdownMenuItem(
                                        key: Key(job),
                                        value: job,
                                        child: Text(job)))
                                    .toList(),
                                validator: (value) =>
                                    textFieldNotNullAndNotEmptyValidator(value),
                                onChanged: (String? value) {
                                  setState(() {
                                    job = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        _divider(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: DropdownButtonFormField(
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
                                                  color: elementColor[element]!
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                              const SizedBox(width: 8.0),
                                              Text(element),
                                            ],
                                          )),
                                    )
                                    .toList(),
                                validator: (value) =>
                                    textFieldNotNullAndNotEmptyValidator(value),
                                onChanged: (String? value) {
                                  setState(() {
                                    element = value!;
                                  });
                                },
                              ),
                            ),
                            _divider(),
                            Expanded(
                              child: DropdownButtonFormField(
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
                                validator: (value) =>
                                    textFieldNotNullAndNotEmptyValidator(value),
                                onChanged: (String? value) {
                                  setState(() {
                                    weaponType = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        _divider(),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Switch(
                              value: isLeader,
                              onChanged: (value) => setState(() {
                                isLeader = value;
                              }),
                            ),
                            _divider(),
                            isLeader
                                ? Text(
                                    '리더입니다.',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )
                                : Text(
                                    "리더가 아닙니다.",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                          ],
                        ),
                        _divider(),
                      ],
                    ),
                  )),
            ),
          );
  }
}
