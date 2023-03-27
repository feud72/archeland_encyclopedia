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
      decoration: elementColor[character.element] != null
          ? BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                  Colors.transparent,
                  elementColor[character.element]!.withAlpha(70),
                ]))
          : null,
      child: ListTile(
        title: Text(character.name),
        subtitle: Text(character.uniqueSkill?.name ?? ""),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 64.0,
              child: character.job != null
                  ? Center(
                      child: Text(
                      character.job ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ))
                  : const SizedBox.shrink(),
            ),
            character.job != null
                ? const AppVerticalDivider()
                : const SizedBox.shrink(),
            SizedBox(
              width: 64.0,
              child: character.rank != null
                  ? Center(
                      child: Text(
                      character.rank ?? "",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ))
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
