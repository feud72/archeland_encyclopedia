import 'package:archeland_encyclopedia/src/constants/terms_in_game.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/domain/artifact.dart';
import 'package:flutter/material.dart';

class AccessoryWidget extends StatelessWidget {
  const AccessoryWidget({Key? key, required this.accessory}) : super(key: key);
  final Artifact accessory;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            accessory.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          accessory.jobs != null && accessory.jobs!.isNotEmpty
              ? Row(
                  children:
                      accessory.jobs!.map((job) => jobIcon[job]!).toList())
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
              accessory.jobs != null && accessory.jobs!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("사용 가능 직업 : ${accessory.jobs!.join(", ")}"),
                        const SizedBox(height: 4),
                      ],
                    )
                  : const SizedBox.shrink(),
              Text(
                '[${accessory.effectName}]',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                accessory.effectDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        )
      ],
    );
  }
}
