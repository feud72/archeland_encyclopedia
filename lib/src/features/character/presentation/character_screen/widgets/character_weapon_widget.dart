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
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              ListTile(
                title: const Text("전용 무기 정보가 없습니다."),
                subtitle: const Text("데이터를 입력해 주세요."),
                trailing: const Icon(Icons.edit_note),
                onTap: () {},
              ),
            ],
          );
  }
}
