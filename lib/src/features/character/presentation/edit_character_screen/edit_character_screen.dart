import 'package:archeland_encyclopedia/src/constants/color_schemes.dart';
import 'package:archeland_encyclopedia/src/constants/terms_in_game.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/edit_character_screen/edit_character_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/edit_character_screen/edit_character_status_provider.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditCharacterScreen extends ConsumerStatefulWidget {
  const EditCharacterScreen({super.key, this.id, this.character});
  final CharacterId? id;
  final Character? character;

  @override
  ConsumerState<EditCharacterScreen> createState() =>
      _EditCharacterScreenState();
}

class _EditCharacterScreenState extends ConsumerState<EditCharacterScreen> {
  final _formKey = GlobalKey<FormState>();

  final CharacterStatus _character = CharacterStatus();

  @override
  void initState() {
    super.initState();
    if (widget.character != null) {
      _character.name = widget.character!.name;
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
      // final characterStatus = ref.read(characterStatusStateProvider);
      final success =
          await ref.read(editCharacterScreenControllerProvider.notifier).submit(
                // character: widget.character,
                // characterStatus: characterStatus,
                characterStatus: _character,
              );
      if (success && mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(editCharacterScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(editCharacterScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () => context.pop(),
        ),
        title: Text(widget.character == null
            ? '새 영웅 입력'
            : '수정 : ${widget.character?.name}'),
        actions: <Widget>[
          TextButton(
              onPressed: state.isLoading ? null : _submit,
              child: const Text("저장"))
        ],
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildBasicInfoForm(),
              const SizedBox(height: 16),
              _buildBaseStatusForm(),
              const SizedBox(height: 16),
              _buildUniqueSkillForm(),
              const SizedBox(height: 16),
              _buildLeaderSkillForm(),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildBaseStatusForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("기초 속성", style: TextStyle(fontSize: 24)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'HP',
          ),
          keyboardAppearance: Brightness.light,
          onChanged: (String? value) {
            setState(() => _character.hp = value);
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '물리 공격력',
          ),
          keyboardAppearance: Brightness.light,
          onChanged: (String? value) {
            setState(() => _character.pAtk = value);
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '마법 공격력',
          ),
          keyboardAppearance: Brightness.light,
          onChanged: (String? value) {
            setState(() => _character.mAtk = value);
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '물리 방어력',
          ),
          keyboardAppearance: Brightness.light,
          onChanged: (String? value) {
            setState(() => _character.pDef = value);
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '마법 방어력',
          ),
          keyboardAppearance: Brightness.light,
          onChanged: (String? value) {
            setState(() => _character.mDef = value);
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '집중력',
          ),
          keyboardAppearance: Brightness.light,
          onChanged: (String? value) {
            setState(() => _character.concentration = value);
          },
        ),
      ],
    );
  }

  Widget _buildBasicInfoForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "기본 정보",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: _character.name,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: '영웅 이름',
            hintText: '예) 레일라',
          ),
          keyboardAppearance: Brightness.light,
          validator: (value) =>
              (value ?? '').isNotEmpty ? null : '이름은 반드시 입력해야 합니다.',
          onSaved: (value) => _character.name = value,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            labelText: '등급',
            border: OutlineInputBorder(),
          ),
          items: rankList
              .map((rank) => DropdownMenuItem(
                  key: Key(rank), value: rank, child: Text(rank)))
              .toList(),
          onChanged: (String? value) {
            setState(() {
              _character.rank = value;
            });
          },
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            labelText: '클래스',
            border: OutlineInputBorder(),
          ),
          items: jobList
              .map((job) =>
                  DropdownMenuItem(key: Key(job), value: job, child: Text(job)))
              .toList(),
          onChanged: (String? value) {
            setState(() {
              _character.job = value;
            });
          },
        ),
        const SizedBox(height: 8),
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
          onChanged: (String? value) {
            setState(() {
              _character.element = value;
            });
          },
        ),
        const SizedBox(height: 8),
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
          onChanged: (String? value) {
            setState(() {
              _character.weaponType = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildUniqueSkillForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("특성", style: TextStyle(fontSize: 24)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            labelText: '스킬명',
            hintText: '예) 철가면 사냥매',
            border: OutlineInputBorder(),
          ),
          keyboardAppearance: Brightness.light,
          onSaved: (value) => _character.uniqueSkillName = value,
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 10,
          minLines: 3,
          decoration: const InputDecoration(
            labelText: '스킬 설명',
            hintText:
                '예) HP 100% 시 치명타 확률이 23/26/30/35% 증가하고 피해를 가할 때 치명타 발동 시 대상에게 랜덤 디버프를 2개 부여한다.',
            border: OutlineInputBorder(),
          ),
          keyboardAppearance: Brightness.light,
          onSaved: (value) => _character.uniqueSkillDescription = value,
        ),
      ],
    );
  }

  Widget _buildLeaderSkillForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("리더 스킬", style: TextStyle(fontSize: 24)),
        const SizedBox(height: 8),
        TextFormField(
          decoration: const InputDecoration(
            labelText: '리더 스킬명',
            hintText: '예) 인과의 윤회',
            border: OutlineInputBorder(),
          ),
          keyboardAppearance: Brightness.light,
          onSaved: (value) => _character.leaderSkillName = value,
        ),
        const SizedBox(height: 8),
        TextFormField(
          maxLines: 10,
          minLines: 3,
          decoration: const InputDecoration(
            labelText: '스킬 설명',
            hintText:
                '예) 이그 및 [레인저], [프리스트] 영웅 최소 1명씩 출전 시 리더 스킬 활성화. 모든 전투 참여 아군 캐릭터 물리 공격력, 물리 방어력, 마법 공격력, 마법 방어력 10% 증가. 이동력 증가 효과 보유 시 가하는 피해 10% 증가',
            border: OutlineInputBorder(),
          ),
          keyboardAppearance: Brightness.light,
          onSaved: (value) => _character.leaderSkillDescription = value,
        ),
      ],
    );
  }
}
