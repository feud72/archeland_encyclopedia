import 'package:archeland_encyclopedia/src/features/artifacts/presentation/artifacts_screen.dart';
import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/account/account_screen.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/character_screen.dart';
import 'package:archeland_encyclopedia/src/features/characters/presentation/characters_screen.dart';
import 'package:archeland_encyclopedia/src/features/land/presentation/land_screen.dart';
import 'package:archeland_encyclopedia/src/features/runes/presentation/rune_screen.dart';
import 'package:archeland_encyclopedia/src/routing/go_router_refresh_stream.dart';
import 'package:archeland_encyclopedia/src/routing/scaffold_with_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  home,
  characters,
  character,
  addCharacter,
  editCharacter,
  artifacts,
  configs,
  land,
  attribute,
  rune,
  academy,
  signIn,
  signInWithGoogle,
  account,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: '/characters',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    // redirect: (context, state) {
    //   final isLoggedIn = authRepository.currentUser != null;
    //   if (!isLoggedIn) {
    //     if (state.location == '/account') {
    //       return '/signIn';
    //     }
    //   } else {
    //     if (state.location == '/signIn') {
    //       return '/account';
    //     }
    //   }
    //   return null;
    // },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/characters',
            name: AppRoute.characters.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const CharactersScreen(),
            ),
            routes: [
              GoRoute(
                path: ':id',
                name: AppRoute.character.name,
                pageBuilder: (context, state) {
                  final id = state.params['id'] ?? '0';
                  return MaterialPage(child: CharacterScreen(characterId: id));
                },
              ),
            ],
          ),
          GoRoute(
            path: '/artifacts',
            name: AppRoute.artifacts.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ArtifactsScreen(),
            ),
            // routes: [],
          ),
          GoRoute(
            path: '/land',
            name: AppRoute.land.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const LandScreen(),
            ),
            // routes: [],
          ),
          GoRoute(
            path: '/rune',
            name: AppRoute.rune.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const RuneScreen(),
            ),
          ),
          // GoRoute(
          //   path: '/configs',
          //   name: AppRoute.configs.name,
          //   pageBuilder: (context, state) => NoTransitionPage(
          //     key: state.pageKey,
          //     child: const ConfigsScreen(),
          //   ),
          //   // routes: [],
          // ),
          GoRoute(
            path: '/account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const AccountScreen(),
            ),
          ),
          GoRoute(
            path: '/signIn',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const SignInScreen(),
            ),
          ),
        ],
      ),
    ],
    //errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
