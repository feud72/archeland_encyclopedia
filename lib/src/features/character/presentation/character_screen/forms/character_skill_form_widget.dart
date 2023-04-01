import 'package:archeland_encyclopedia/src/common_widgets/alert_dialogs.dart';
import 'package:archeland_encyclopedia/src/constants/terms_in_game.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/character_screen_controller.dart';
import 'package:archeland_encyclopedia/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CharacterSkillForm extends ConsumerStatefulWidget {
  const CharacterSkillForm(
      {Key? key, required this.character, required this.position})
      : super(key: key);
  final String position;
  final Character character;

  @override
  ConsumerState<CharacterSkillForm> createState() => _CharacterSkillFormState();
}

class _CharacterSkillFormState extends ConsumerState<CharacterSkillForm> {
  late String position;
  late String? name;
  int cost = 1;
  String coolTime = CoolTime.zero;
  String rangePrefix = RangePrefix.none;
  String? range;
  String radiusPrefix = RadiusPrefix.none;
  String? radius;
  String? type;
  late String? description;
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
      String radiusText = '';
      String rangeText = '';
      switch (rangePrefix) {
        case RangePrefix.none:
          rangeText = RangePrefix.none;
          break;
        case RangePrefix.self:
          rangeText = RangePrefix.self;
          break;
        case RangePrefix.nthBlock:
          rangeText = '$range';
          break;
        case RangePrefix.cross:
          rangeText = '십자 $range';
          break;
      }
      switch (radiusPrefix) {
        case RadiusPrefix.none:
          radiusText = RadiusPrefix.none;
          break;
        case RadiusPrefix.single:
          radiusText = RadiusPrefix.single;
          break;
        case RadiusPrefix.line:
          radiusText = '직선 $radius';
          break;
        case RadiusPrefix.round:
          radiusText = '주변 $radius';
          break;
        case RadiusPrefix.diamond:
          radiusText = '마름모 $radius';
          break;
        case RadiusPrefix.entire:
          radiusText = RadiusPrefix.entire;
          break;
        case RadiusPrefix.threeByFour:
          radiusText = RadiusPrefix.threeByFour;
          break;
      }
      final success = await ref
          .read(characterScreenControllerProvider.notifier)
          .submitSkillForm(
            character: widget.character,
            name: name!,
            coolTime: coolTime,
            cost: cost,
            description: description!,
            type: type!,
            range: rangeText,
            radius: radiusText,
            position: position,
          );
      if (success && mounted) {
        context.pop();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    position = widget.position;
  }

  Widget _divider() => const SizedBox(width: 16, height: 16);

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
                                "스킬 입력",
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
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '스킬명',
                            ),
                            keyboardAppearance: Brightness.light,
                            onChanged: (String? value) =>
                                setState(() => name = value),
                            validator: (value) =>
                                textFieldNotNullAndNotEmptyValidator(value),
                          ),
                          _divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: '유형',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: type,
                                  items: const [
                                    DropdownMenuItem(
                                      value: Type.pAtk,
                                      child: Center(
                                        child: Text(Type.pAtk),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: Type.mAtk,
                                      child: Center(
                                        child: Text(Type.mAtk),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: Type.active,
                                      child: Center(
                                        child: Text(Type.active),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: Type.passive,
                                      child: Center(
                                        child: Text(Type.passive),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: Type.heal,
                                      child: Center(
                                        child: Text(Type.heal),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: Type.support,
                                      child: Center(
                                        child: Text(Type.support),
                                      ),
                                    ),
                                  ],
                                  validator: (value) =>
                                      textFieldNotNullAndNotEmptyValidator(
                                          value),
                                  onChanged: (String? value) {
                                    setState(() {
                                      type = value!;
                                    });
                                  },
                                ),
                              ),
                              _divider(),
                              Expanded(
                                flex: 2,
                                child: DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    labelText: '쿨타임',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: coolTime,
                                  items: const [
                                    DropdownMenuItem(
                                      value: CoolTime.zero,
                                      child: Text(CoolTime.zero),
                                    ),
                                    DropdownMenuItem(
                                      value: CoolTime.one,
                                      child: Text(CoolTime.one),
                                    ),
                                    DropdownMenuItem(
                                      value: CoolTime.two,
                                      child: Text(CoolTime.two),
                                    ),
                                    DropdownMenuItem(
                                      value: CoolTime.three,
                                      child: Text(CoolTime.three),
                                    ),
                                    DropdownMenuItem(
                                      value: CoolTime.four,
                                      child: Text(CoolTime.four),
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      coolTime = value!;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                flex: 1,
                                child: DropdownButtonFormField<int>(
                                  decoration: const InputDecoration(
                                    labelText: '코스트',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: cost,
                                  items: const [
                                    DropdownMenuItem(
                                      value: 1,
                                      child: Text("1"),
                                    ),
                                    DropdownMenuItem(
                                      value: 2,
                                      child: Text("2"),
                                    ),
                                  ],
                                  onChanged: (int? value) {
                                    setState(() {
                                      cost = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          _divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String?>(
                                  decoration: const InputDecoration(
                                    labelText: '사정거리',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: rangePrefix,
                                  items: const [
                                    DropdownMenuItem(
                                      value: RangePrefix.none,
                                      child: Text(RangePrefix.none),
                                    ),
                                    DropdownMenuItem(
                                      value: RangePrefix.self,
                                      child: Text(RangePrefix.self),
                                    ),
                                    DropdownMenuItem(
                                      value: RangePrefix.cross,
                                      child: Text(RangePrefix.cross),
                                    ),
                                    DropdownMenuItem(
                                      value: RangePrefix.nthBlock,
                                      child: Text(RangePrefix.nthBlock),
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      rangePrefix = value!;
                                      if (rangePrefix == RangePrefix.none ||
                                          rangePrefix == RangePrefix.self) {
                                        range = null;
                                      }
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                  width: (rangePrefix == RangePrefix.nthBlock ||
                                          rangePrefix == RangePrefix.cross)
                                      ? 16
                                      : 0),
                              rangePrefix == RangePrefix.nthBlock ||
                                      rangePrefix == RangePrefix.cross
                                  ? Expanded(
                                      child: DropdownButtonFormField<String?>(
                                        decoration: const InputDecoration(
                                          labelText: '칸',
                                          border: OutlineInputBorder(),
                                        ),
                                        value: range,
                                        items: const [
                                          DropdownMenuItem(
                                            value: "1칸",
                                            child: Text("1칸"),
                                          ),
                                          DropdownMenuItem(
                                            value: "2칸",
                                            child: Text("2칸"),
                                          ),
                                          DropdownMenuItem(
                                            value: "3칸",
                                            child: Text("3칸"),
                                          ),
                                          DropdownMenuItem(
                                            value: "4칸",
                                            child: Text("4칸"),
                                          ),
                                        ],
                                        onChanged: (String? value) =>
                                            setState(() => range = value),
                                        validator: (value) {
                                          if (value == null) {
                                            if (rangePrefix !=
                                                    RangePrefix.none &&
                                                rangePrefix !=
                                                    RangePrefix.self) {
                                              return '값을 입력해야 합니다.';
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          _divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: DropdownButtonFormField<String?>(
                                  decoration: const InputDecoration(
                                    labelText: '범위',
                                    border: OutlineInputBorder(),
                                  ),
                                  value: radiusPrefix,
                                  items: const [
                                    DropdownMenuItem(
                                      value: RadiusPrefix.none,
                                      child: Text(RadiusPrefix.none),
                                    ),
                                    DropdownMenuItem(
                                      value: RadiusPrefix.single,
                                      child: Text(RadiusPrefix.single),
                                    ),
                                    DropdownMenuItem(
                                      value: RadiusPrefix.line,
                                      child: Text(RadiusPrefix.line),
                                    ),
                                    DropdownMenuItem(
                                      value: RadiusPrefix.threeByFour,
                                      child: Text(RadiusPrefix.threeByFour),
                                    ),
                                    DropdownMenuItem(
                                      value: RadiusPrefix.round,
                                      child: Text(RadiusPrefix.round),
                                    ),
                                    DropdownMenuItem(
                                      value: RadiusPrefix.diamond,
                                      child: Text(RadiusPrefix.diamond),
                                    ),
                                    DropdownMenuItem(
                                      value: RadiusPrefix.entire,
                                      child: Text(RadiusPrefix.entire),
                                    ),
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      radiusPrefix = value!;
                                      if (radiusPrefix == RadiusPrefix.single ||
                                          radiusPrefix == RadiusPrefix.none ||
                                          radiusPrefix ==
                                              RadiusPrefix.threeByFour ||
                                          radiusPrefix == RadiusPrefix.entire) {
                                        radius = null;
                                      }
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                  width: (radiusPrefix == RadiusPrefix.none ||
                                          radiusPrefix == RadiusPrefix.single ||
                                          radiusPrefix ==
                                              RadiusPrefix.threeByFour ||
                                          radiusPrefix == RadiusPrefix.entire)
                                      ? 0
                                      : 16),
                              radiusPrefix == RadiusPrefix.diamond ||
                                      radiusPrefix == RadiusPrefix.line
                                  ? Expanded(
                                      child: DropdownButtonFormField<String?>(
                                        decoration: const InputDecoration(
                                          labelText: '칸',
                                          border: OutlineInputBorder(),
                                        ),
                                        value: radius,
                                        items: const [
                                          DropdownMenuItem(
                                            value: "2칸",
                                            child: Text("2칸"),
                                          ),
                                          DropdownMenuItem(
                                            value: "3칸",
                                            child: Text("3칸"),
                                          ),
                                          DropdownMenuItem(
                                            value: "4칸",
                                            child: Text("4칸"),
                                          ),
                                          DropdownMenuItem(
                                            value: "5칸",
                                            child: Text("5칸"),
                                          ),
                                        ],
                                        onChanged: (String? value) =>
                                            setState(() => radius = value),
                                        validator: (value) {
                                          if (value == null) {
                                            if (radiusPrefix !=
                                                    RadiusPrefix.single &&
                                                radiusPrefix !=
                                                    RadiusPrefix.none) {
                                              return '값을 입력해야 합니다.';
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              radiusPrefix == RadiusPrefix.round
                                  ? Expanded(
                                      child: DropdownButtonFormField<String?>(
                                        decoration: const InputDecoration(
                                          labelText: '바퀴',
                                          border: OutlineInputBorder(),
                                        ),
                                        value: radius,
                                        items: const [
                                          DropdownMenuItem(
                                            value: "1바퀴",
                                            child: Text("1바퀴"),
                                          ),
                                          DropdownMenuItem(
                                            value: "2바퀴",
                                            child: Text("2바퀴"),
                                          ),
                                          DropdownMenuItem(
                                            value: "3바퀴",
                                            child: Text("3바퀴"),
                                          ),
                                        ],
                                        onChanged: (String? value) =>
                                            setState(() => radius = value),
                                        validator: (value) {
                                          if (value == null) {
                                            if (radiusPrefix !=
                                                    RadiusPrefix.single &&
                                                radiusPrefix !=
                                                    RadiusPrefix.none) {
                                              return '값을 입력해야 합니다.';
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          _divider(),
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
                            validator: (value) =>
                                textFieldNotNullAndNotEmptyValidator(value),
                            onSaved: (value) => description = value,
                          ),
                          _divider(),
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
