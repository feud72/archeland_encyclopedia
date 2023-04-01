import 'package:archeland_encyclopedia/src/constants/terms_in_game.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/domain/artifact.dart';
import 'package:flutter/material.dart';

class ArmorWidget extends StatelessWidget {
  const ArmorWidget({Key? key, required this.armor}) : super(key: key);
  final Artifact armor;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${armor.name} • ${armor.subName!}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          armor.jobs != null && armor.jobs!.isNotEmpty
              ? Row(children: armor.jobs!.map((job) => jobIcon[job]!).toList())
              : const SizedBox.shrink(),
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
              armor.jobs != null && armor.jobs!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("사용 가능 직업 : ${armor.jobs!.join(", ")}"),
                        const SizedBox(height: 4),
                      ],
                    )
                  : const SizedBox.shrink(),
              Text(
                '[${armor.effectName}]',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                armor.effectDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        )
      ],
    );
  }
}
