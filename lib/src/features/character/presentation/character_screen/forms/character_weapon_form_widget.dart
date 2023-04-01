import 'package:archeland_encyclopedia/src/common_widgets/alert_dialogs.dart';
import 'package:archeland_encyclopedia/src/common_widgets/asking_editing_listtile.dart';
import 'package:archeland_encyclopedia/src/constants/terms_in_game.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/character_screen_controller.dart';
import 'package:archeland_encyclopedia/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CharacterWeaponFormWidget extends StatelessWidget {
  const CharacterWeaponFormWidget({Key? key, required this.character})
      : super(key: key);
  final Character character;

  @override
  Widget build(BuildContext context) {
    return AskingEditingListTile(
        onTap: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => EditWeaponForm(
                character: character,
              ),
            ),
        title: "전용 무기 정보가 없습니다.",
        subtitle: "데이터를 입력해 주세요.");
  }
}

class EditWeaponForm extends ConsumerStatefulWidget {
  const EditWeaponForm({
    Key? key,
    this.character,
  }) : super(key: key);
  final Character? character;

  @override
  ConsumerState<EditWeaponForm> createState() => _EditWeaponFormState();
}

class _EditWeaponFormState extends ConsumerState<EditWeaponForm> {
  late String? name;
  late final String? weaponType;
  String? effectName;
  String? effectDescription;
  String? uniqueEffectName;
  String? uniqueEffectDescription;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    weaponType = widget.character?.weaponType;
    uniqueEffectName =
        widget.character != null ? '${widget.character!.name} 전용 효과' : null;
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
          .read(characterScreenControllerProvider.notifier)
          .submitWeapon(
            character: widget.character!,
            name: name!,
            weaponType: weaponType!,
            effectName: effectName!,
            effectDescription: effectDescription!,
            uniqueEffectName: uniqueEffectName!,
            uniqueEffectDescription: uniqueEffectDescription!,
          );
      if (success && mounted) {
        context.pop();
      }
    }
  }

  Widget _divider() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterScreenControllerProvider);
    return state.isLoading
        ? const CircularProgressIndicator()
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${widget.character != null ? "전용" : ""} 무기 입력",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const Expanded(child: SizedBox()),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      final result = await showAlertDialog(
                                          title: '취소',
                                          content: '작성을 취소하고 나가시겠습니까?',
                                          cancelActionText: '취소',
                                          context: context);
                                      if (!mounted) return;
                                      return result! ? context.pop() : null;
                                    },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor:
                                            ThemeData().colorScheme.onPrimary,
                                        backgroundColor: ThemeData()
                                            .colorScheme
                                            .errorContainer
                                            .withOpacity(0.8)),
                                    child: const Text("취소"),
                                  ),
                                  const SizedBox(width: 16),
                                  ElevatedButton(
                                    onPressed: state.isLoading ? null : _submit,
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.indigo),
                                    child: const Text("제출"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          _divider(),
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '무기 이름',
                              hintText: '예) 하늘의 요새',
                            ),
                            keyboardAppearance: Brightness.light,
                            onChanged: (String? value) =>
                                setState(() => name = value),
                            validator: (value) =>
                                textFieldNotNullAndNotEmptyValidator(value),
                          ),
                          _divider(),
                          if (weaponType == null) ...[
                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: '무기 타입',
                                border: OutlineInputBorder(),
                              ),
                              value: weaponType,
                              items: weaponTypeList
                                  .map((weapon) => DropdownMenuItem(
                                      value: weapon, child: Text(weapon)))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  weaponType = value!;
                                });
                              },
                              validator: (value) =>
                                  textFieldNotNullAndNotEmptyValidator(value),
                            ),
                            _divider()
                          ],
                          TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '장비 특성',
                              hintText: '예) 하늘의 요새',
                            ),
                            keyboardAppearance: Brightness.light,
                            onChanged: (String? value) =>
                                setState(() => effectName = value),
                            validator: (value) =>
                                textFieldNotNullAndNotEmptyValidator(value),
                          ),
                          _divider(),
                          TextFormField(
                            maxLines: 3,
                            minLines: 1,
                            decoration: const InputDecoration(
                              labelText: '특성 효과',
                              hintText:
                                  '예) 물리 공격력 +5/6/7/8/10%, HP +1/2/3/4/5%',
                              border: OutlineInputBorder(),
                            ),
                            keyboardAppearance: Brightness.light,
                            onChanged: (value) => effectDescription = value,
                            validator: (value) =>
                                textFieldNotNullAndNotEmptyValidator(value),
                          ),
                          if (widget.character != null) ...[
                            _divider(),
                            TextFormField(
                              maxLines: 10,
                              minLines: 2,
                              decoration: const InputDecoration(
                                labelText: '전용 효과 설명',
                                hintText:
                                    '예) HP 70% 이상 시 피해 면역 5/7/9/12/15% 증가. [빛의 에너지 방패] 상태 보유 중일 때 공격 받은 후 랜덤 [디버프] 1/1/1/1/2개 랜덤 [버프] 효과로 변경',
                                border: OutlineInputBorder(),
                              ),
                              keyboardAppearance: Brightness.light,
                              onChanged: (value) =>
                                  uniqueEffectDescription = value,
                              validator: (value) =>
                                  textFieldNotNullAndNotEmptyValidator(value),
                            ),
                            _divider(),
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
