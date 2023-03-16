import 'package:archeland_encyclopedia/src/constants/color_schemes.dart';
import 'package:archeland_encyclopedia/src/features/characters/data/characters_repository.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/character_screen/character_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/character_screen/widgets/character_basic_info_widget.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/character_screen/widgets/character_skill_list_widget.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/character_screen/widgets/character_status_widget.dart';
import 'package:archeland_encyclopedia/src/routing/app_router.dart';
import 'package:archeland_encyclopedia/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CharacterScreen extends ConsumerWidget {
  final String characterId;

  const CharacterScreen({required this.characterId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(characterScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final characterAsyncValue = ref.watch(characterStreamProvider(characterId));
    return characterAsyncValue.when(
        data: (character) {
          const List<Tab> tabs = <Tab>[
            Tab(text: '스테이터스'),
            Tab(text: '기본 정보'),
            Tab(text: '스킬'),
          ];
          return DefaultTabController(
            length: tabs.length,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.transparent,
                    elementColor[character.element]!.withAlpha(50),
                  ])),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(character.name),
                  actions: [
                    IconButton(
                        onPressed: () {
                          context.goNamed(
                            AppRoute.editCharacter.name,
                            params: {'id': characterId},
                          );
                        },
                        icon: const Icon(Icons.edit))
                  ],
                  bottom: const TabBar(
                    tabs: tabs,
                  ),
                ),
                body: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: CharacterStatusWidget(character: character),
                    ),
                    SingleChildScrollView(
                        child: CharacterBasicInfoWidget(character: character)),
                    SingleChildScrollView(
                        child: CharacterSkillListWidget(character: character)),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, stacktrace) => Center(
              child: Column(
                children: [
                  Text(error.toString()),
                  Text(stacktrace.toString()),
                ],
              ),
            ),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
