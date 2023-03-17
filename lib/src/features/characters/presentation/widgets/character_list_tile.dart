import 'package:archeland_encyclopedia/src/common_widgets/custom_divider.dart';
import 'package:archeland_encyclopedia/src/constants/color_schemes.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:flutter/material.dart';

class CharacterListTile extends StatelessWidget {
  const CharacterListTile({Key? key, required this.character, this.onTap})
      : super(key: key);
  final Character character;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.transparent,
                elementColor[character.element]!.withAlpha(70),
              ])),
      child: ListTile(
        title: Text(character.name),
        subtitle: Text(character.uniqueSkill?.name ?? ""),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 64.0,
              child: character.job != null
                  ? Center(child: Text(character.job ?? ""))
                  : const SizedBox.shrink(),
            ),
            character.job != null
                ? const CustomVerticalDivider()
                : const SizedBox.shrink(),
            SizedBox(
              width: 72.0,
              child: Center(child: Text(character.weaponType ?? "")),
            ),
            character.weaponType != null
                ? const CustomVerticalDivider()
                : const SizedBox.shrink(),
            SizedBox(
              width: 64.0,
              child: character.rank != null
                  ? Center(child: Text(character.rank ?? ""))
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
