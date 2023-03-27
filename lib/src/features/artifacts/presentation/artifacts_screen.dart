import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/characters_search_state_provider.dart';
import 'package:archeland_encyclopedia/src/routing/app_router.dart';
import 'package:archeland_encyclopedia/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ArtifactsScreen extends ConsumerWidget {
  const ArtifactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser;

    final provider = charactersSearchResultsProvider;
    final charactersAsyncValue = ref.watch(provider);
    ref.listen<AsyncValue>(
        provider, (_, state) => state.showAlertDialogOnError(context));
    return charactersAsyncValue.when(
        data: (character) {
          const List<Tab> tabs = <Tab>[
            Tab(text: '무기'),
            Tab(text: '투구'),
            Tab(text: '갑옷'),
            Tab(text: '장신구'),
          ];
          return DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: tabs,
                ),
              ),
              body: const TabBarView(
                children: [
                  Center(child: Text('무기')),
                  Center(child: Text('투구')),
                  Center(child: Text('갑옷')),
                  Center(child: Text('장신구')),
                ],
              ),
              floatingActionButton: user != null
                  ? FloatingActionButton(
                      mini: true,
                      onPressed: () =>
                          context.goNamed(AppRoute.addCharacter.name),
                      child: const Icon(Icons.add))
                  : const SizedBox.shrink(),
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
