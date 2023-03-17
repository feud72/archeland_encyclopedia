import 'package:archeland_encyclopedia/src/common_widgets/custom_modal_bottom_sheet.dart';
import 'package:archeland_encyclopedia/src/constants/terms_in_game.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future showEditingSkillBottomSheet({
  required BuildContext context,
  required String position,
}) async {
  return showCustomModalBottomSheet(
    context: context,
    widget: EditSkillForm(position: position),
  );
}

class EditSkillForm extends StatefulWidget {
  const EditSkillForm({Key? key, required this.position}) : super(key: key);

  final String position;

  @override
  State<EditSkillForm> createState() => _EditSkillFormState();
}

class _EditSkillFormState extends State<EditSkillForm> {
  late String? name;
  int cost = 1;
  String? coolTime;
  String? rangePrefix;
  String? range;
  String? radiusPrefix;
  String? radius;
  String? type;
  late String? description;
  final _formKey = GlobalKey<FormState>();

  Widget _divider() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    Text(
                      "스킬 입력",
                      style: Theme.of(context).textTheme.titleLarge,
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
                    ),
                    _divider(),
                    Row(
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
                            onChanged: (String? value) {
                              setState(() {
                                type = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String?>(
                            decoration: const InputDecoration(
                              labelText: '쿨타임',
                              border: OutlineInputBorder(),
                            ),
                            value: coolTime,
                            items: const [
                              DropdownMenuItem(
                                value: null,
                                child: Text("-"),
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
                                coolTime = value;
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
                                value: null,
                                child: Text("-"),
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
                                rangePrefix = value;
                                if (rangePrefix == null ||
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
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    _divider(),
                    Row(
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
                                value: null,
                                child: Text("-"),
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
                                value: RadiusPrefix.round,
                                child: Text(RadiusPrefix.round),
                              ),
                              DropdownMenuItem(
                                value: RadiusPrefix.diamond,
                                child: Text(RadiusPrefix.diamond),
                              ),
                            ],
                            onChanged: (String? value) {
                              setState(() {
                                radiusPrefix = value;
                                if (radiusPrefix == RadiusPrefix.single ||
                                    radiusPrefix == null) {
                                  radius = null;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                            width: (radiusPrefix == null ||
                                    radiusPrefix == RadiusPrefix.single)
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
                      onSaved: (value) => description = value,
                    ),
                    _divider(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => context.pop(),
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.red),
                            child: const Text("취소"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              //Todo: submit 기능
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.indigo),
                            child: const Text("제출"),
                          ),
                        ),
                      ],
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
