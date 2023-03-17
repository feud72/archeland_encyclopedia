import 'package:archeland_encyclopedia/src/common_widgets/asking_editing_listtile.dart';
import 'package:archeland_encyclopedia/src/common_widgets/custom_divider.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/special_skill.dart';
import 'package:flutter/material.dart';

class CharacterSpecialSkillWidget extends StatelessWidget {
  const CharacterSpecialSkillWidget({
    Key? key,
    required this.skill,
    required this.title,
  }) : super(key: key);
  final String title;
  final SpecialSkill? skill;

  @override
  Widget build(BuildContext context) {
    return skill != null
        ? Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      skill!.name ?? "",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(title),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  skill!.description ?? "(알 수 없음)",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          )
        : Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomDivider(),
              ),
              AskingEditingListTile(
                  onTap: () {
                    //Todo: 리더 스킬 및 특성 입력 폼 작성
                  },
                  title: "$title 정보가 없습니다.",
                  subtitle: "데이터를 입력해 주세요."),
            ],
          );
  }
}
