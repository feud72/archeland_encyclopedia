import 'package:archeland_encyclopedia/src/common_widgets/asking_editing_listtile.dart';
import 'package:archeland_encyclopedia/src/common_widgets/custom_divider.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/skill.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/edit_character_screen/widgets/edit_skill_modal_bottomsheet.dart';
import 'package:flutter/material.dart';

class CharacterSkillWidget extends StatelessWidget {
  const CharacterSkillWidget({
    Key? key,
    this.skill,
    required this.title,
    this.level,
    required this.position,
  }) : super(key: key);

  final Skill? skill;
  final String title;
  final int? level;
  final String position;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildSkillTitleWidget(title: title, level: level),
        BuildSkillTileWidget(skill: skill, position: position),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomDivider(),
        ),
      ],
    );
  }
}

class BuildSkillTitleWidget extends StatelessWidget {
  const BuildSkillTitleWidget({Key? key, required this.title, this.level})
      : super(key: key);

  final String title;
  final int? level;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyLarge),
          Text(
            "Lv. ${level != null ? level.toString() : "조건 없음"}",
          ),
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
  });

  final Skill? skill;
  final String position;

  @override
  Widget build(BuildContext context) {
    return skill != null
        ? ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(skill?.name ?? ""),
                Text("◆" * (skill?.cost ?? 0)),
              ],
            ),
            subtitle: Column(
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
            onTap: () => showEditingSkillBottomSheet(
                  context: context,
                  position: position,
                ),
            title: "스킬 정보가 없습니다.",
            subtitle: "데이터를 입력해 주세요.");
  }
}
