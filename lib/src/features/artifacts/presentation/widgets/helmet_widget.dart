import 'package:archeland_encyclopedia/src/constants/terms_in_game.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/domain/artifact.dart';
import 'package:flutter/material.dart';

class HelmetWidget extends StatelessWidget {
  const HelmetWidget({Key? key, required this.helmet}) : super(key: key);
  final Artifact helmet;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${helmet.name} • ${helmet.subName!}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          helmet.jobs != null && helmet.jobs!.isNotEmpty
              ? Row(
                  children: helmet.jobs?.map((job) => jobIcon[job]!).toList() ??
                      [const SizedBox.shrink()],
                )
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
              helmet.jobs != null && helmet.jobs!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("사용 가능 직업 : ${helmet.jobs!.join(", ")}"),
                        const SizedBox(height: 4),
                      ],
                    )
                  : const SizedBox.shrink(),
              Text(
                '[${helmet.effectName}]',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                helmet.effectDescription,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        )
      ],
    );
  }
}
