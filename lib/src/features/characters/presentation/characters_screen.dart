import 'package:archeland_encyclopedia/src/common_widgets/list_items_builder.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/characters_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/characters_search_state_provider.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/widgets/character_list_tile.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/widgets/characters_add_new_character_form_widget.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/widgets/characters_search_text_field.dart';
import 'package:archeland_encyclopedia/src/routing/app_router.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CharactersScreen extends ConsumerWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = charactersScreenControllerProvider;
    ref.listen<AsyncValue>(
        provider, (_, state) => state.showAlertDialogOnError(context));
    final charactersStream = ref.watch(charactersSearchResultsProvider);
    return Scaffold(
      body: Column(
        children: [
          const CharactersSearchTextField(),
          Expanded(
            child: ListItemsBuilder(
              data: charactersStream,
              itemBuilder: (context, character) {
                return CharacterListTile(
                  character: character,
                  onTap: () => context.goNamed(AppRoute.character.name,
                      params: {'id': character.id}),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: kDebugMode
          ? FloatingActionButton(
              mini: true,
              onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => const CharactersAddNewCharacterForm(),
              ),
              child: Icon(Icons.add, color: Colors.grey.shade700),
            )
          : const SizedBox.shrink(),
    );
  }
}
