import 'package:archeland_encyclopedia/src/common_widgets/custom_divider.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/forms/character_weapon_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterWeaponWidget extends ConsumerWidget {
  const CharacterWeaponWidget({required this.character, Key? key})
      : super(key: key);
  final Character character;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return character.weapon != null
        // weapon != null
        ? Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      character.weapon!.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('전용 무기'),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  '[${character.weapon!.effectName}]',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  character.weapon!.effectDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  character.weapon!.uniqueEffectDescription != null
                      ? '[${character.weapon!.uniqueEffectName}]'
                      : "",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  character.weapon!.uniqueEffectDescription != null
                      ? "${character.weapon!.uniqueEffectDescription}"
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
                child: AppDivider(),
              ),
              Container(),
              CharacterWeaponFormWidget(character: character),
            ],
          );
  }
}
