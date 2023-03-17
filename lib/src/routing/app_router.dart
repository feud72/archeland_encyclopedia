import 'package:archeland_encyclopedia/src/features/artifacts/presentation/artifacts_main/artifacts_main_screen.dart';
import 'package:archeland_encyclopedia/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/account/account_screen.dart';
import 'package:archeland_encyclopedia/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/character_screen/character_screen.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/edit_character_screen/edit_character_screen.dart';
import 'package:archeland_encyclopedia/src/features/character/presentation/edit_character_screen/new_edit_character_screen.dart';
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
    redirect: (context, state) {
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.subloc.startsWith('/signIn')) {
          return '/characters';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SignInScreen(),
        ),
      ),
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
                  path: 'add',
                  name: AppRoute.addCharacter.name,
                  pageBuilder: (context, state) {
                    return MaterialPage(
                      key: state.pageKey,
                      fullscreenDialog: true,
                      child: const EditCharacterScreen(),
                    );
                  },
                ),
                GoRoute(
                  path: ':id',
                  name: AppRoute.character.name,
                  pageBuilder: (context, state) {
                    final id = state.params['id'] ?? '0';
                    return MaterialPage(
                        child: CharacterScreen(characterId: id));
                  },
                  routes: [
                    GoRoute(
                      path: 'edit',
                      name: AppRoute.editCharacter.name,
                      pageBuilder: (context, state) {
                        final id = state.params['id'] ?? '0';
                        debugPrint(state.name);
                        debugPrint(state.fullpath);
                        debugPrint(state.subloc);
                        debugPrint(state.path);
                        debugPrint(state.location);
                        return MaterialPage(
                          key: state.pageKey,
                          fullscreenDialog: true,
                          child: NewEditCharacterScreen(characterId: id),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: '/artifacts',
              name: AppRoute.artifacts.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const ArtifactsMainScreen(),
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
            GoRoute(
              path: '/account',
              name: AppRoute.account.name,
              pageBuilder: (context, state) => NoTransitionPage(
                key: state.pageKey,
                child: const AccountScreen(),
              ),
            ),
          ]),

      // GoRoute(
      //   path: '/signIn',
      //   name: AppRoute.signIn.name,
      //   pageBuilder: (context, state) => NoTransitionPage(
      //     key: state.pageKey,
      //     child: const SignInScreen(),
      //   ),
      //   routes: [
      //     GoRoute(
      //       path: 'emailPassword',
      //       name: AppRoute.emailPassword.name,
      //       pageBuilder: (context, state) => MaterialPage(
      //         key: state.pageKey,
      //         fullscreenDialog: true,
      //         child: const EmailPasswordSignInScreen(
      //           formType: EmailPasswordSignInFormType.signIn,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      // ShellRoute(
      //   navigatorKey: _shellNavigatorKey,
      //   builder: (context, state, child) {
      //     return ScaffoldWithBottomNavBar(child: child);
      //   },
      //   routes: [
      //     GoRoute(
      //       path: '/jobs',
      //       name: AppRoute.jobs.name,
      //       pageBuilder: (context, state) => NoTransitionPage(
      //         key: state.pageKey,
      //         child: const JobsScreen(),
      //       ),
      //       routes: [
      //         GoRoute(
      //           path: 'add',
      //           name: AppRoute.addJob.name,
      //           parentNavigatorKey: _rootNavigatorKey,
      //           pageBuilder: (context, state) {
      //             return MaterialPage(
      //               key: state.pageKey,
      //               fullscreenDialog: true,
      //               child: const EditJobScreen(),
      //             );
      //           },
      //         ),
      //         GoRoute(
      //           path: ':id',
      //           name: AppRoute.job.name,
      //           pageBuilder: (context, state) {
      //             final id = state.params['id']!;
      //             return MaterialPage(
      //               key: state.pageKey,
      //               child: JobEntriesScreen(jobId: id),
      //             );
      //           },
      //           routes: [
      //             GoRoute(
      //               path: 'entries/add',
      //               name: AppRoute.addEntry.name,
      //               parentNavigatorKey: _rootNavigatorKey,
      //               pageBuilder: (context, state) {
      //                 final jobId = state.params['id']!;
      //                 return MaterialPage(
      //                   key: state.pageKey,
      //                   fullscreenDialog: true,
      //                   child: EntryScreen(
      //                     jobId: jobId,
      //                   ),
      //                 );
      //               },
      //             ),
      //             GoRoute(
      //               path: 'entries/:eid',
      //               name: AppRoute.entry.name,
      //               pageBuilder: (context, state) {
      //                 final jobId = state.params['id']!;
      //                 final entryId = state.params['eid']!;
      //                 final entry = state.extra as Entry?;
      //                 return MaterialPage(
      //                   key: state.pageKey,
      //                   child: EntryScreen(
      //                     jobId: jobId,
      //                     entryId: entryId,
      //                     entry: entry,
      //                   ),
      //                 );
      //               },
      //             ),
      //             GoRoute(
      //               path: 'edit',
      //               name: AppRoute.editJob.name,
      //               pageBuilder: (context, state) {
      //                 final jobId = state.params['id'];
      //                 final job = state.extra as Job?;
      //                 return MaterialPage(
      //                   key: state.pageKey,
      //                   fullscreenDialog: true,
      //                   child: EditJobScreen(jobId: jobId, job: job),
      //                 );
      //               },
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //     GoRoute(
      //       path: '/entries',
      //       name: AppRoute.entries.name,
      //       pageBuilder: (context, state) => NoTransitionPage(
      //         key: state.pageKey,
      //         child: const EntriesScreen(),
      //       ),
      //     ),
      //     GoRoute(
      //       path: '/account',
      //       name: AppRoute.account.name,
      //       pageBuilder: (context, state) => NoTransitionPage(
      //         key: state.pageKey,
      //         child: const AccountScreen(),
      //       ),
      //     ),
      //   ],
      // ),
    ],
    //errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
