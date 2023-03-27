import 'package:archeland_encyclopedia/src/features/artifacts/domain/weapon.dart';
import 'package:flutter/material.dart';

class WeaponWidget extends StatelessWidget {
  const WeaponWidget({
    Key? key,
    required this.title,
    required this.weapon,
  }) : super(key: key);

  final String title;
  final Weapon? weapon;

  @override
  Widget build(BuildContext context) {
    return weapon != null
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      weapon!.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Row(
                      children: [
                        Text(title),
                        weapon?.weaponType != null
                            ? const VerticalDivider(color: Colors.transparent)
                            : const SizedBox.shrink(),
                        weapon?.weaponType != null
                            ? Text(weapon!.weaponType)
                            : const SizedBox.shrink(),
                      ],
                    ),
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
                  '[${weapon!.uniqueEffectName}]',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  weapon!.uniqueEffectDescription!,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
