import 'package:archeland_encyclopedia/src/common_widgets/advertise_widget.dart';
import 'package:archeland_encyclopedia/src/localization/string_hardcoded.dart';
import 'package:archeland_encyclopedia/src/routing/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  final Widget child;

  const ScaffoldWithBottomNavBar({Key? key, required this.child})
      : super(key: key);

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _selectedIndex = 0;

  void _tap(BuildContext context, int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        context.goNamed(AppRoute.characters.name);
        break;
      case 1:
        context.goNamed(AppRoute.artifacts.name);
        break;
      case 2:
        context.goNamed(AppRoute.land.name);
        break;
      case 3:
        context.goNamed(AppRoute.rune.name);
        break;
      case 4:
        context.goNamed(AppRoute.account.name);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 80,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: kDebugMode
              ? const Center(
                  child: Center(
                    child: Text("광고 자리"),
                  ),
                )
              : const AdvertiseWidget(),
        ),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.people), label: '영웅'.hardcoded),
          BottomNavigationBarItem(
              icon: const Icon(Icons.shield), label: '장비'.hardcoded),
          BottomNavigationBarItem(
              icon: const Icon(Icons.castle), label: '약속의 땅'.hardcoded),
          BottomNavigationBarItem(
              icon: const Icon(Icons.hexagon_outlined), label: '룬'.hardcoded),
          BottomNavigationBarItem(
              icon: const Icon(Icons.manage_accounts), label: '계정'.hardcoded),
        ],
        onTap: (index) => _tap(context, index),
      ),
    );
  }
}
