import 'package:archeland_encyclopedia/src/features/artifacts/presentation/artifact_provider.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/presentation/artifacts_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/presentation/widgets/helmet_widget.dart';
import 'package:archeland_encyclopedia/src/features/search/query_provider.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HelmetsPage extends ConsumerWidget {
  const HelmetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helmets = ref.watch(helmetsProvider);
    final query = ref.watch(queryProvider);

    return FirestoreListView(
      query: helmets.orderBy('name'),
      emptyBuilder: (context) => const Center(child: Text('데이터가 존재하지 않습니다.')),
      errorBuilder: (context, error, stackTrace) =>
          Center(child: Text(error.toString())),
      loadingBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
      itemBuilder: (context, doc) {
        final helmet = doc.data();
        return ref
                .read(artifactsScreenControllerProvider.notifier)
                .isQueryMatched(helmet, query)
            ? Column(
                children: [
                  HelmetWidget(helmet: helmet),
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
