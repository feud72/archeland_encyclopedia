import 'package:archeland_encyclopedia/src/features/artifacts/presentation/artifact_provider.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/presentation/artifacts_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/presentation/widgets/armor_widget.dart';
import 'package:archeland_encyclopedia/src/features/search/query_provider.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArmorsPage extends ConsumerWidget {
  const ArmorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final armors = ref.watch(armorsProvider);
    final query = ref.watch(queryProvider);

    return FirestoreListView(
      query: armors.orderBy('name'),
      emptyBuilder: (context) => const Center(child: Text('데이터가 존재하지 않습니다.')),
      errorBuilder: (context, error, stackTrace) =>
          Center(child: Text(error.toString())),
      loadingBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
      itemBuilder: (context, doc) {
        final armor = doc.data();
        return ref
                .read(artifactsScreenControllerProvider.notifier)
                .isQueryMatched(armor, query)
            ? Column(
                children: [
                  ArmorWidget(armor: armor),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(color: Colors.grey.withOpacity(0.3)),
                  ),
                ],
              )
            : const SizedBox.shrink();
      },
    );
  }
}
