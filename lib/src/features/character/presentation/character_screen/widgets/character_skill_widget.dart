import 'package:archeland_encyclopedia/src/common_widgets/asking_editing_listtile.dart';
import 'package:archeland_encyclopedia/src/common_widgets/custom_divider.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/skill.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/edit_widgets/edit_skill_form_widget.dart';
import 'package:flutter/material.dart';

class CharacterSkillWidget extends StatelessWidget {
  const CharacterSkillWidget({
    Key? key,
    this.skill,
    required this.title,
    this.level,
    required this.position,
    required this.character,
  }) : super(key: key);

  final Character character;
  final Skill? skill;
  final String title;
  final int? level;
  final String position;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildSkillTitleWidget(
            title: skill?.name ?? title, cost: skill?.cost, level: level),
        BuildSkillTileWidget(
            skill: skill, position: position, character: character),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class BuildSkillTitleWidget extends StatelessWidget {
  const BuildSkillTitleWidget(
      {Key? key, required this.title, this.level, this.cost})
      : super(key: key);

  final String title;
  final int? level;
  final int? cost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              Row(
                children: [
                  Text(
                    "◆" * (cost ?? 0),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const AppVerticalDivider(),
                  Text(
                    "Lv. ${level != null ? level.toString() : "조건 없음"}",
                  ),
                ],
              ),
            ],
          ),
          const AppDivider(),
        ],
      ),
    );
  }
}

class BuildSkillTileWidget extends StatelessWidget {
  const BuildSkillTileWidget({
    super.key,
    required this.skill,
    required this.position,
    required this.character,
  });

  final Character character;
  final Skill? skill;
  final String position;

  @override
  Widget build(BuildContext context) {
    return skill != null
        ? ListTile(
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    skill?.type != null
                        ? Expanded(child: Text('유형 : ${skill?.type}'))
                        : const SizedBox.shrink(),
                    skill?.coolTime != null
                        ? Expanded(child: Text('쿨타임 : ${skill?.coolTime}'))
                        : const SizedBox.shrink(),
                  ],
                ),
                Row(
                  children: [
                    skill?.range != null
                        ? Expanded(child: Text('사정거리 : ${skill?.range}'))
                        : const SizedBox.shrink(),
                    skill?.radius != null
                        ? Expanded(child: Text('범위 : ${skill?.radius}'))
                        : const SizedBox.shrink(),
                  ],
                ),
                const CustomTransparentDivider(),
                Text(skill?.description ?? ""),
              ],
            ),
          )
        : AskingEditingListTile(
            onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) =>
                      EditSkillForm(position: position, character: character),
                ),
            title: "스킬 정보가 없습니다.",
            subtitle: "데이터를 입력해 주세요.");
  }
}
