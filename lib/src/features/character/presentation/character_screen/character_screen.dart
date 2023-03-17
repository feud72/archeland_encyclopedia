import 'package:archeland_encyclopedia/src/constants/color_schemes.dart';
import 'package:archeland_encyclopedia/src/features/character/data/character_repository.dart';
import 'package:archeland_encyclopedia/src/features/character/domain/character.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/widgets/character_basic_info_widget.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/widgets/character_skill_list_widget.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/widgets/character_status_widget.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterScreen extends ConsumerWidget {
  final CharacterId characterId;

  const CharacterScreen({required this.characterId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = characterStreamProvider(characterId);
    final characterAsyncValue = ref.watch(provider);
    ref.listen<AsyncValue>(
        provider, (_, state) => state.showAlertDialogOnError(context));
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
                    tabs: tabs,
                  ),
                ),
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CharacterStatusWidget(character: character),
                    CharacterBasicInfoWidget(character: character),
                    CharacterSkillListWidget(character: character),
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
