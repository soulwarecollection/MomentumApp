import 'package:go_router/go_router.dart';
import 'package:momentum/core/common/widgets/scaffold_with_nav.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/features/library/domain/entities/exercise.dart';
import 'package:momentum/features/library/presentation/pages/catalog_exercise_detail_page.dart';
import 'package:momentum/features/library/presentation/pages/library_page.dart';
import 'package:momentum/features/logging/presentation/pages/logging_page.dart'
    show LoggingPage, StartSessionArgs;
import 'package:momentum/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:momentum/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:momentum/features/paywall/domain/pro_access_policy.dart';
import 'package:momentum/features/paywall/presentation/pages/paywall_page.dart';
import 'package:momentum/features/progress/presentation/pages/exercise_detail_page.dart';
import 'package:momentum/features/progress/presentation/pages/history_page.dart';
import 'package:momentum/features/progress/presentation/pages/pr_detail_page.dart';
import 'package:momentum/features/progress/presentation/pages/progress_page.dart';
import 'package:momentum/features/progress/presentation/pages/session_detail_page.dart';
import 'package:momentum/features/routines/presentation/pages/plan_editor_page.dart';
import 'package:momentum/features/routines/presentation/pages/plan_schedule_page.dart';
import 'package:momentum/features/routines/presentation/pages/plans_page.dart';
import 'package:momentum/features/schedule/presentation/pages/today_page.dart';
import 'package:momentum/features/settings/presentation/pages/profile_page.dart';
import 'package:momentum/features/styleguide/presentation/pages/styleguide_page.dart';
import 'package:momentum/features/sync/presentation/pages/sign_in_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/today',
  redirect: (context, state) {
    final onboarded = getIt<OnboardingRepository>().hasCompletedOnboarding();
    final atOnboarding = state.matchedLocation == '/onboarding';
    if (!onboarded && !atOnboarding) return '/onboarding';
    if (onboarded && atOnboarding) return '/today';
    return null;
  },
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => ScaffoldWithNav(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/today',
              builder: (context, state) => const TodayPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/plans',
              builder: (context, state) => const PlansPage(),
              routes: [
                GoRoute(
                  path: 'schedule',
                  builder: (context, state) => const PlanSchedulePage(),
                ),
                GoRoute(
                  path: ':id/edit',
                  builder: (context, state) => PlanEditorPage(
                    planId: int.parse(
                      state.pathParameters['id']!,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/progress',
              builder: (context, state) => const ProgressPage(),
              routes: [
                GoRoute(
                  path: 'history',
                  builder: (context, state) => const HistoryPage(),
                ),
                GoRoute(
                  path: 'session/:id',
                  builder: (context, state) => SessionDetailPage(
                    id: state.pathParameters['id']!,
                  ),
                ),
                GoRoute(
                  path: 'exercise/:id',
                  builder: (context, state) => ExerciseDetailPage(
                    id: state.pathParameters['id']!,
                  ),
                ),
                GoRoute(
                  path: 'pr/:id',
                  builder: (context, state) => PrDetailPage(
                    id: state.pathParameters['id']!,
                    exerciseName: state.extra as String?,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/you',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/log',
      builder: (context, state) =>
          LoggingPage(args: state.extra as StartSessionArgs?),
    ),
    GoRoute(
      path: '/paywall',
      builder: (context, state) => PaywallPage(
        feature: state.extra as ProFeature?,
      ),
    ),
    GoRoute(
      path: '/library',
      builder: (context, state) => const LibraryPage(),
      routes: [
        GoRoute(
          path: 'exercise',
          builder: (context, state) => CatalogExerciseDetailPage(
            exercise: state.extra! as Exercise,
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/styleguide',
      builder: (context, state) => const StyleguidePage(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => const SignInPage(),
    ),
  ],
);
