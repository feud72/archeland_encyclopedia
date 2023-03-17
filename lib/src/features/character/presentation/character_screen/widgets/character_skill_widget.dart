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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              Text("Lv. ${level != null ? level.toString() : "조건 없음"}",
                  style: Theme.of(context).textTheme.titleSmall),
            ],
          ),
          Container(
            constraints: const BoxConstraints(minHeight: 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.white.withOpacity(0.3)),
            child: skill != null
                ? BuildSkillTileWidget(skill: skill)
                : Center(
                    child: ListTile(
                      title: const Text("스킬 정보가 없습니다."),
                      subtitle: const Text("스킬 정보를 추가해 주세요."),
                      trailing: IconButton(
                          onPressed: () => showEditingSkillBottomSheet(
                                context: context,
                                position: position,
                              ),
                          icon: const Icon(Icons.edit)),
                    ),
                  ),
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
  });

  final Skill? skill;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
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
            const Divider(
              color: Colors.transparent,
            ),
            Text(skill?.description ?? ""),
          ],
        ),
      ),
    );
  }
}
