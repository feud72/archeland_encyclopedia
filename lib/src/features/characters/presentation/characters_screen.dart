import 'package:archeland_encyclopedia/src/common_widgets/list_items_builder.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/characters_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/characters_search_state_provider.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/widgets/character_list_tile.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/widgets/characters_search_text_field.dart';
import 'package:archeland_encyclopedia/src/routing/app_router.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const CharactersSearchTextField()),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Consumer(
          builder: (context, ref, child) {
            ref.listen<AsyncValue>(charactersScreenControllerProvider,
                (_, state) => state.showAlertDialogOnError(context));
            final charactersAsyncValue =
                ref.watch(charactersSearchResultsProvider);
            // ref.watch(charactersScreenControllerProvider);
            return ListItemsBuilder(
              data: charactersAsyncValue,
              itemBuilder: (context, character) => CharacterListTile(
                character: character,
                onTap: () => context.goNamed(AppRoute.character.name,
                    params: {'id': character.id}),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          mini: true,
          onPressed: () => context.goNamed(AppRoute.addCharacter.name),
          child: const Icon(Icons.add)),
    );
  }
}
