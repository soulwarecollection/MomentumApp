import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momentum/core/db/app_database.dart';
import 'package:momentum/core/db/seed_sample_sessions.dart'
    show seedProExtras, seedSampleSessions;
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/core/notifications/notification_service.dart';
import 'package:momentum/core/theme/brand_tokens.dart';
import 'package:momentum/core/theme/theme_cubit.dart';
import 'package:momentum/features/paywall/domain/pro_access_policy.dart';
import 'package:momentum/features/paywall/presentation/cubits/entitlement_cubit.dart';
import 'package:momentum/features/paywall/presentation/widgets/pro_gate.dart';
import 'package:momentum/features/sync/presentation/cubits/account_cubit.dart';
import 'package:momentum/features/sync/presentation/cubits/sync_status_cubit.dart';
import 'package:momentum/features/sync/sync_service.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final db = getIt<AppDatabase>();
    return StreamBuilder<List<SessionRow>>(
      stream: db.sessionsDao.watchActiveSessions(),
      builder: (context, snapshot) {
        final sessions = snapshot.data ?? [];
        return _ProfileBody(sessions: sessions);
      },
    );
  }
}

class _ProfileBody extends StatelessWidget {
  const _ProfileBody({required this.sessions});

  final List<SessionRow> sessions;

  int get _streak {
    if (sessions.isEmpty) {
      return 0;
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final uniqueDays =
        sessions
            .map(
              (s) => DateTime(
                s.startedAt.year,
                s.startedAt.month,
                s.startedAt.day,
              ),
            )
            .toSet()
            .toList()
          ..sort((a, b) => b.compareTo(a));

    var streak = 0;
    DateTime? cursor;
    for (final day in uniqueDays) {
      if (cursor == null) {
        if (day == today || day == today.subtract(const Duration(days: 1))) {
          streak = 1;
          cursor = day;
        } else {
          break;
        }
      } else if (day == cursor.subtract(const Duration(days: 1))) {
        streak++;
        cursor = day;
      } else {
        break;
      }
    }
    return streak;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    final streak = _streak;
    final entitlement = context.watch<EntitlementCubit>().state;
    final isPro = entitlement.isPro;

    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 128),
          children: [
            Text(
              'YOU',
              style: theme.textTheme.labelSmall?.copyWith(
                color: tokens.faint,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.4,
              ),
            ),
            Text(
              'Wageesha',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.55,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Training since March · ${sessions.length} sessions',
              style: theme.textTheme.bodyMedium?.copyWith(color: tokens.muted),
            ),
            const SizedBox(height: 16),
            _ProCard(
              isPro: isPro,
              onUpgrade: () => unawaited(
                requirePro(context, feature: ProFeature.unlimitedPlans),
              ),
            ),
            const SizedBox(height: 16),

            // ── Stats grid ──────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    value: '$streak',
                    label: 'Day streak',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    value: '${sessions.length}',
                    label: 'Total sessions',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Goals ───────────────────────────────────────────────────
            Row(
              children: [
                const Expanded(child: _SectionHeader(label: 'Goals')),
                Text(
                  'Edit',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _GoalCard(
              label: 'Bench press 100 kg',
              value: '95 / 100',
              progress: 0.95,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 10),
            _GoalCard(
              label: '4 sessions / week',
              value: '4 / 4',
              progress: 1,
              color: tokens.good,
            ),
            const SizedBox(height: 10),
            _GoalCard(
              label: 'Run 25 km / week',
              value: '18 / 25',
              progress: 0.72,
              color: tokens.cardio,
            ),
            const SizedBox(height: 24),

            // ── Settings ────────────────────────────────────────────────
            const _SectionHeader(label: 'Settings'),
            const SizedBox(height: 8),
            _SettingsGroup(
              children: [
                _ThemeTile(),
                _Divider(),
                _SettingsTile(
                  icon: PhosphorIconsRegular.ruler,
                  title: 'Units',
                  subtitle: 'kg / km',
                  onTap: () {},
                ),
                _Divider(),
                _SettingsTile(
                  icon: PhosphorIconsRegular.lockSimple,
                  title: 'Privacy',
                  subtitle: 'Workouts private by default',
                  trailing: const _OnBadge(),
                  onTap: () {},
                ),
                _Divider(),
                const _SyncTile(),
                _Divider(),
                _SettingsTile(
                  icon: PhosphorIconsRegular.watch,
                  title: 'Apple Watch & Wear OS',
                  subtitle: 'Log from your wrist',
                  trailing: isPro ? const _OnBadge() : const _ProBadge(),
                  onTap: () => unawaited(
                    _openProFeature(
                      context,
                      feature: ProFeature.wearable,
                      unlockedMessage: 'Watch logging is unlocked for Pro.',
                    ),
                  ),
                ),
                _Divider(),
                const _WorkoutReminderTile(),
                _Divider(),
                _SettingsTile(
                  icon: PhosphorIconsRegular.downloadSimple,
                  title: 'Export my data',
                  subtitle: 'CSV or JSON · you own it',
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Export stays free — preparing your data.'),
                    ),
                  ),
                ),
                _Divider(),
                _SeedDataTile(),
              ],
            ),
            if (entitlement.isProTestingEnabled) ...[
              const SizedBox(height: 24),
              const _SectionHeader(label: 'Developer & QA'),
              const SizedBox(height: 8),
              const _SettingsGroup(
                children: [
                  _DebugProTile(),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _openProFeature(
    BuildContext context, {
    required ProFeature feature,
    required String unlockedMessage,
  }) async {
    final unlocked = await requirePro(context, feature: feature);
    if (!unlocked || !context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(unlockedMessage)));
  }
}

// ── Pro card ─────────────────────────────────────────────────────────────────

class _ProCard extends StatelessWidget {
  const _ProCard({required this.isPro, required this.onUpgrade});

  final bool isPro;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            if (isPro) tokens.goodSoft else tokens.primarySoft,
            theme.colorScheme.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(tokens.radiusLarge),
        border: Border.all(color: tokens.line2),
        boxShadow: tokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: isPro ? tokens.good : theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  PhosphorIconsRegular.lightning,
                  color: theme.colorScheme.onPrimary,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Momentum Pro',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      isPro
                          ? 'Active · thanks for supporting Momentum'
                          : 'Unlimited plans · full analytics · sync & Watch',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: tokens.muted,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              if (isPro)
                Icon(PhosphorIconsRegular.check, color: tokens.good, size: 22),
            ],
          ),
          if (!isPro) ...[
            const SizedBox(height: 12),
            Text(
              r'$3.49/mo · $23.99/yr · $59.99 lifetime',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: tokens.muted,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onUpgrade,
                child: const Text('Upgrade to Pro'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Goals ────────────────────────────────────────────────────────────────────

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
  });

  final String label;
  final String value;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tokens.line),
        boxShadow: tokens.cardShadow,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: progress,
              color: color,
              backgroundColor: theme.colorScheme.surfaceContainer,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat card ────────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = context.brandTokens;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        border: Border.all(color: tokens.line),
        boxShadow: tokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.muted),
          ),
        ],
      ),
    );
  }
}

// ── Section header ───────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: context.brandTokens.muted,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    );
  }
}

// ── Settings group ───────────────────────────────────────────────────────────

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(tokens.radiusCard),
        border: Border.all(color: tokens.line),
        boxShadow: tokens.cardShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      color: context.brandTokens.line,
    );
  }
}

class _ProBadge extends StatelessWidget {
  const _ProBadge();

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: tokens.accentSoft,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'PRO',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: tokens.accent,
          fontSize: 9,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _OnBadge extends StatelessWidget {
  const _OnBadge();

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: tokens.goodSoft,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        'On',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: tokens.good,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ── Settings tile ────────────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    return ListTile(
      leading: Icon(icon, size: 20, color: tokens.muted),
      title: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: tokens.muted),
            )
          : null,
      trailing:
          trailing ?? const Icon(PhosphorIconsRegular.caretRight, size: 18),
      onTap: onTap,
      dense: true,
    );
  }
}

// ── Theme toggle tile ────────────────────────────────────────────────────────

class _ThemeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ThemeCubit>().state;
    final (label, icon) = switch (mode) {
      ThemeMode.system => ('System', PhosphorIconsRegular.circleHalf),
      ThemeMode.light => ('Light', PhosphorIconsRegular.sun),
      ThemeMode.dark => ('Dark', PhosphorIconsRegular.moon),
    };

    return _SettingsTile(
      icon: icon,
      title: 'Appearance',
      subtitle: label,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.brandTokens.muted,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(PhosphorIconsRegular.caretRight, size: 18),
        ],
      ),
      onTap: () {
        final next = switch (mode) {
          ThemeMode.system => ThemeMode.light,
          ThemeMode.light => ThemeMode.dark,
          ThemeMode.dark => ThemeMode.system,
        };
        unawaited(context.read<ThemeCubit>().setThemeMode(next));
      },
    );
  }
}

class _DebugProTile extends StatelessWidget {
  const _DebugProTile();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EntitlementCubit>().state;
    return _SettingsTile(
      icon: PhosphorIconsRegular.flask,
      title: 'Test Momentum Pro',
      subtitle: state.isDebugOverride
          ? 'Local Pro preview is on'
          : 'Preview every Pro feature on this device',
      trailing: Switch.adaptive(
        value: state.isDebugOverride,
        onChanged: (value) => unawaited(
          context.read<EntitlementCubit>().setDebugPro(value: value),
        ),
      ),
      onTap: () => unawaited(
        context.read<EntitlementCubit>().toggleDebugPro(),
      ),
    );
  }
}

// ── Seed data tile ───────────────────────────────────────────────────────────

class _SeedDataTile extends StatefulWidget {
  @override
  State<_SeedDataTile> createState() => _SeedDataTileState();
}

class _SeedDataTileState extends State<_SeedDataTile> {
  bool _seeding = false;

  Future<void> _addSampleData() async {
    setState(() => _seeding = true);
    try {
      final isPro = context.read<EntitlementCubit>().state.isPro;
      final db = getIt<AppDatabase>();
      final seeded = await seedSampleSessions(db);
      final proSeeded = isPro && await seedProExtras(db);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (seeded || proSeeded)
                ? isPro
                      ? 'Pro sample data added — 4 plans, 20 sessions seeded.'
                      : 'Sample data added! Check Today and Progress.'
                : 'Sample data already loaded.',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _seeding = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPro = context.watch<EntitlementCubit>().state.isPro;
    return _SettingsTile(
      icon: PhosphorIconsRegular.database,
      title: 'Add sample data',
      subtitle: isPro
          ? 'Creates 4 plans (PPL · Full Body · Upper/Lower · Cardio) '
                'with 20 sessions.'
          : 'Creates 2 plans (PPL · Full Body) with 6 logged sessions.',
      trailing: _seeding
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(PhosphorIconsRegular.caretRight, size: 18),
      onTap: _seeding ? null : _addSampleData,
    );
  }
}

// ── Sync tile ────────────────────────────────────────────────────────────────

class _SyncTile extends StatelessWidget {
  const _SyncTile();

  @override
  Widget build(BuildContext context) {
    final isPro = context.watch<EntitlementCubit>().state.isPro;

    if (!isPro) {
      return _SettingsTile(
        icon: PhosphorIconsRegular.cloud,
        title: 'Cloud sync & backup',
        subtitle: 'Across all your devices',
        trailing: const _ProBadge(),
        onTap: () => unawaited(
          requirePro(context, feature: ProFeature.cloudSync),
        ),
      );
    }

    final accountState = context.watch<AccountCubit>().state;
    final syncState = context.watch<SyncStatusCubit>().state;

    if (accountState is AccountSignedIn) {
      final lastSyncLabel = switch (syncState) {
        SyncInProgress() => 'Syncing…',
        SyncDone(:final lastSync) => 'Last synced ${_fmt(lastSync)}',
        SyncError(:final message) => 'Sync error: $message',
        _ => 'Tap to sync now',
      };

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SettingsTile(
            icon: PhosphorIconsRegular.cloudCheck,
            title: accountState.email,
            subtitle: lastSyncLabel,
            trailing: syncState is SyncInProgress
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const _OnBadge(),
            onTap: syncState is SyncInProgress
                ? null
                : () {
                    context.read<SyncStatusCubit>().onSyncStarted();
                    getIt<SyncService>().syncInBackground();
                  },
          ),
          _Divider(),
          _SettingsTile(
            icon: PhosphorIconsRegular.signOut,
            title: 'Sign out',
            subtitle: 'Sync paused when signed out',
            onTap: () => unawaited(
              context.read<AccountCubit>().signOut(),
            ),
          ),
        ],
      );
    }

    // Pro but not signed in
    return _SettingsTile(
      icon: PhosphorIconsRegular.cloud,
      title: 'Cloud sync & backup',
      subtitle: 'Sign in to sync across devices',
      trailing: const Icon(PhosphorIconsRegular.caretRight, size: 18),
      onTap: () => context.push('/signin'),
    );
  }

  static String _fmt(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

// ── Workout reminder tile ────────────────────────────────────────────────────

class _WorkoutReminderTile extends StatefulWidget {
  const _WorkoutReminderTile();

  @override
  State<_WorkoutReminderTile> createState() => _WorkoutReminderTileState();
}

class _WorkoutReminderTileState extends State<_WorkoutReminderTile> {
  static const _enabledKey = 'reminder_enabled';
  static const _hourKey = 'reminder_hour';
  static const _minuteKey = 'reminder_minute';

  late final SharedPreferences _prefs;
  bool _enabled = false;
  int _hour = 9;
  int _minute = 0;

  @override
  void initState() {
    super.initState();
    _prefs = getIt<SharedPreferences>();
    _enabled = _prefs.getBool(_enabledKey) ?? false;
    _hour = _prefs.getInt(_hourKey) ?? 9;
    _minute = _prefs.getInt(_minuteKey) ?? 0;
  }

  String get _timeLabel {
    final h = _hour % 12 == 0 ? 12 : _hour % 12;
    final m = _minute.toString().padLeft(2, '0');
    final period = _hour < 12 ? 'AM' : 'PM';
    return '$h:$m $period';
  }

  Future<void> _toggle(bool value) async {
    if (value) {
      final picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: _hour, minute: _minute),
      );
      if (picked == null) return;
      _hour = picked.hour;
      _minute = picked.minute;
      await _prefs.setInt(_hourKey, _hour);
      await _prefs.setInt(_minuteKey, _minute);
      await _prefs.setBool(_enabledKey, true);
      await getIt<NotificationService>().scheduleWorkoutReminder(
        hour: _hour,
        minute: _minute,
      );
    } else {
      await _prefs.setBool(_enabledKey, false);
      await getIt<NotificationService>().cancelWorkoutReminder();
    }
    setState(() => _enabled = value);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.brandTokens;
    return ListTile(
      leading: Icon(
        PhosphorIconsRegular.bell,
        size: 20,
        color: tokens.muted,
      ),
      title: Text(
        'Workout reminder',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        _enabled ? 'Daily at $_timeLabel' : 'Off',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: tokens.muted),
      ),
      trailing: Switch(
        value: _enabled,
        onChanged: _toggle,
      ),
      onTap: _enabled
          ? () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(hour: _hour, minute: _minute),
              );
              if (picked == null || !mounted) return;
              _hour = picked.hour;
              _minute = picked.minute;
              await _prefs.setInt(_hourKey, _hour);
              await _prefs.setInt(_minuteKey, _minute);
              await getIt<NotificationService>().scheduleWorkoutReminder(
                hour: _hour,
                minute: _minute,
              );
              setState(() {});
            }
          : null,
      dense: true,
    );
  }
}
