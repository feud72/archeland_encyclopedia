import 'package:archeland_encyclopedia/src/constants/color_schemes.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/character_screen_controller.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/pages/character_info_page.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/pages/character_skill_page.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/pages/character_status_page.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterScreen extends ConsumerWidget {
  final CharacterId characterId;

  const CharacterScreen({required this.characterId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterAsyncValue = ref.watch(characterStreamProvider(characterId));
    ref.listen<AsyncValue>(characterScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
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
                  bottom: const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: tabs,
                  ),
                ),
                body: TabBarView(
                  children: [
                    CharacterStatusPage(character: character),
                    CharacterInfoPage(character: character),
                    CharacterSkillPage(character: character),
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
