import 'package:archeland_encyclopedia/src/features/artifacts/domain/artifact.dart';
import 'package:flutter/material.dart';

class WeaponWidget extends StatelessWidget {
  const WeaponWidget({Key? key, required this.weapon}) : super(key: key);
  final Artifact weapon;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${weapon.name} • ${weapon.subName!}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            weapon.weaponType!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      iconColor: Theme.of(context).primaryColor,
      shape: const RoundedRectangleBorder(
          side: BorderSide(style: BorderStyle.none)),
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '[${weapon.effectName}]',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    weapon.effectDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
