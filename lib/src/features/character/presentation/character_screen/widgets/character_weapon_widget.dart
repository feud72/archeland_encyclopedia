import 'package:archeland_encyclopedia/src/common_widgets/asking_editing_listtile.dart';
import 'package:archeland_encyclopedia/src/common_widgets/custom_divider.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/domain/weapon.dart';
import 'package:flutter/material.dart';

class CharacterWeaponWidget extends StatelessWidget {
  const CharacterWeaponWidget({Key? key, required this.title, this.weapon})
      : super(key: key);

  final String title;
  final Weapon? weapon;

  @override
  Widget build(BuildContext context) {
    return weapon != null
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
                      weapon!.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(title),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  '[${weapon!.effectName}]',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  weapon!.effectDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  weapon!.uniqueEffectDescription != null
                      ? '[${weapon!.uniqueEffectName}]'
                      : "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  weapon!.uniqueEffectDescription != null
                      ? "${weapon!.uniqueEffectDescription}"
                      : "",
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
                    //Todo : 전용 무기 입력 폼 작성
                  },
                  title: "$title 정보가 없습니다.",
                  subtitle: "데이터를 입력해 주세요."),
            ],
          );
  }
}
