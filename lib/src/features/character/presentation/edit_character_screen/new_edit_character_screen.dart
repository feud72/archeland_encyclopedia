import 'package:archeland_encyclopedia/src/constants/color_schemes.dart';
import 'package:archeland_encyclopedia/src/constants/terms_in_game.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/edit_character_screen/edit_character_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/edit_character_screen/edit_character_status_provider.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/edit_character_screen/widgets/edit_basic_info_form_widget.dart';
import 'package:archeland_encyclopedia/src/features/characters/data/characters_repository.dart';
import 'package:archeland_encyclopedia/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewEditCharacterScreen extends ConsumerStatefulWidget {
  const NewEditCharacterScreen({super.key, this.characterId});
  final CharacterId? characterId;

  @override
  ConsumerState<NewEditCharacterScreen> createState() =>
      _NewEditCharacterScreenState();
}

class _NewEditCharacterScreenState
    extends ConsumerState<NewEditCharacterScreen> {
  final _formKey = GlobalKey<FormState>();

  final CharacterStatus _character = CharacterStatus();

  @override
  void initState() {
    super.initState();
    if (widget.characterId != null) {
      final character = ref
          .read(charactersRemoteRepositoryProvider)
          .characters
          .value
          ?.firstWhere((character) => character.id == widget.characterId);
      _character.name = character!.name;
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
        title: Text(
            widget.characterId == null ? '새 영웅 입력' : '수정 : ${_character.name}'),
        actions: <Widget>[
          TextButton(
              onPressed: state.isLoading ? null : _submit,
              child: const Text("저장"))
        ],
      ),
      body: const SingleChildScrollView(child: EditBasicInfoFormWidget()),
    );
  }

  List<Widget> _buildBaseStatusForm() {
    final ranks = ['S', 'A', 'B', 'C'];
    return [
      const Text("기초 속성", style: TextStyle(fontSize: 24)),
      const SizedBox(height: 8),
      DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: 'HP',
          border: OutlineInputBorder(),
        ),
        items: ranks
            .map((rank) => DropdownMenuItem(
                key: Key('hp-$rank'), value: rank, child: Text(rank)))
            .toList(),
        onChanged: (String? value) {
          setState(() {
            _character.hp = value;
          });
        },
      ),
      const SizedBox(height: 8),
      DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: '물리 공격력',
          border: OutlineInputBorder(),
        ),
        items: ranks
            .map((rank) => DropdownMenuItem(
                key: Key('pAtk-$rank'), value: rank, child: Text(rank)))
            .toList(),
        onChanged: (String? value) {
          setState(() {
            _character.pAtk = value;
          });
        },
      ),
      const SizedBox(height: 8),
      DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: '마법 공격력',
          border: OutlineInputBorder(),
        ),
        items: ranks
            .map((rank) => DropdownMenuItem(
                key: Key('mAtk-$rank'), value: rank, child: Text(rank)))
            .toList(),
        onChanged: (String? value) {
          setState(() {
            _character.mAtk = value;
          });
        },
      ),
      const SizedBox(height: 8),
      DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: '물리 방어력',
          border: OutlineInputBorder(),
        ),
        items: ranks
            .map((rank) => DropdownMenuItem(
                key: Key('pDef-$rank'), value: rank, child: Text(rank)))
            .toList(),
        onChanged: (String? value) {
          setState(() {
            _character.pDef = value;
          });
        },
      ),
      const SizedBox(height: 8),
      DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: '마법 방어력',
          border: OutlineInputBorder(),
        ),
        items: ranks
            .map((rank) => DropdownMenuItem(
                key: Key('mDef-$rank'), value: rank, child: Text(rank)))
            .toList(),
        onChanged: (String? value) {
          setState(() {
            _character.mDef = value;
          });
        },
      ),
      const SizedBox(height: 8),
      DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: '집중력',
          border: OutlineInputBorder(),
        ),
        items: ranks
            .map((rank) => DropdownMenuItem(
                key: Key('concentration-$rank'),
                value: rank,
                child: Text(rank)))
            .toList(),
        onChanged: (String? value) {
          setState(() {
            _character.concentration = value;
          });
        },
      ),
    ];
  }

  List<Widget> _buildBasicInfoForm() {
    return [
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
    ];
  }

  List<Widget> _buildUniqueSkillForm() {
    return [
      const Text("고유 스킬", style: TextStyle(fontSize: 24)),
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
    ];
  }
}
