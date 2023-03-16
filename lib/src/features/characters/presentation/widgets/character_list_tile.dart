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
    return ListTile(
      title: Text(character.name),
      subtitle: Text(character.job ?? ""),
      trailing: SizedBox(
          child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(character.weaponType ?? ""),
          character.weaponType != null
              ? VerticalDivider(
                  color: Colors.grey.shade300,
                )
              : const SizedBox.shrink(),
          SizedBox(
            width: 16.0,
            height: 16.0,
            child: character.element != null
                ? ColoredBox(
                    color: elementColor[character.element]!.withOpacity(0.5),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      )),
      onTap: onTap,
    );
  }
}
