import 'package:archeland_encyclopedia/src/common_widgets/alert_dialogs.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/presentation/pages/accessories_page.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/presentation/pages/armors_page.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/presentation/pages/helmets_page.dart';
import 'package:archeland_encyclopedia/src/features/artifacts/presentation/pages/weapons_page.dart';
import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:archeland_encyclopedia/src/features/search/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArtifactsScreen extends ConsumerWidget {
  const ArtifactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider).currentUser;

    const List<Tab> tabs = <Tab>[
      Tab(text: '무기'),
      Tab(text: '투구'),
      Tab(text: '갑옷'),
      Tab(text: '장신구'),
    ];

    return Column(
      children: [
        const SearchTextField(),
        Expanded(
          child: DefaultTabController(
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
                  WeaponsPage(),
                  HelmetsPage(),
                  ArmorsPage(),
                  AccessoriesPage(),
                ],
              ),
              floatingActionButton: user != null
                  ? FloatingActionButton(
                      mini: true,
                      // onPressed: () => showModalBottomSheet(
                      //       isScrollControlled: true,
                      //       context: context,
                      //       builder: (context) => const AddWeaponForm(),
                      //     ),
                      onPressed: () => showAlertDialog(
                          context: context,
                          title: '알림',
                          content: '기능을 준비 중입니다.'),
                      child: const Icon(Icons.add))
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }
}
