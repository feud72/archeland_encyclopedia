import 'package:archeland_encyclopedia/src/features/characters/presentation/characters_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/widgets/character_list_tile.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/widgets/characters_add_character_form_widget.dart';
import 'package:archeland_encyclopedia/src/features/search/query_provider.dart';
import 'package:archeland_encyclopedia/src/features/search/search_text_field.dart';
import 'package:archeland_encyclopedia/src/routing/app_router.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CharactersScreen extends ConsumerWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(charactersScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final query = ref.watch(queryProvider);
    final characters = ref.watch(charactersProvider);
    return Scaffold(
      body: Column(
        children: [
          const SearchTextField(),
          Expanded(
            child: FirestoreListView(
                query: characters.orderBy('name'),
                emptyBuilder: (context) =>
                    const Center(child: Text('데이터가 존재하지 않습니다.')),
                errorBuilder: (context, error, stackTrace) =>
                    Center(child: Text(error.toString())),
                loadingBuilder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                itemBuilder: (context, doc) {
                  final character = doc.data();
                  return ref
                          .read(charactersScreenControllerProvider.notifier)
                          .isQueryMatched(character, query)
                      ? CharacterListTile(
                          character: character,
                          onTap: () => context.goNamed(AppRoute.character.name,
                              params: {'id': character.id}),
                        )
                      : const SizedBox.shrink();
                }),
          ),
        ],
      ),
      floatingActionButton: kDebugMode
          ? FloatingActionButton(
              mini: true,
              onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => const CharactersAddCharacterForm(),
              ),
              child: Icon(Icons.add, color: Colors.grey.shade700),
            )
          : const SizedBox.shrink(),
    );
  }
}
