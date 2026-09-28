import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/features/bases/widgets/rounded_back_button.dart';
import 'package:corrispay/features/notifications/models/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import '../../../l10n/app_localizations.dart';
import '../providers/notifications.providers.dart';

class NotificationsView extends ConsumerWidget {
  const NotificationsView({super.key});

  Future<void> _onRefresh(WidgetRef ref) async {
    ref.invalidate(getNotificationsProvider);
    // On attend que le nouveau fetch soit terminé pour que le spinner
    // de pull-to-refresh reste visible jusqu'à la fin du chargement.
    await ref.read(getNotificationsProvider.future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = AppLocalizations.of(context)!;
    final notificationsAsync = ref.watch(getNotificationsProvider);

    return Scaffold(
      backgroundColor: Palette.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NotificationsHeader(),
          Expanded(
            child: RefreshIndicator(
              color: Palette.petrolBlue,
              onRefresh: () => _onRefresh(ref),
              child: notificationsAsync.when(
                data: (response) {
                  if (response == null || !response.status) {
                    return _ScrollableWrapper(
                      child: NotificationsErrorBody(
                        message: response?.message ?? tr.common_error,
                        btnText: tr.retry,
                        onRetry: () => ref.invalidate(getNotificationsProvider),
                      ),
                    );
                  }
                  if (response.data.isEmpty) {
                    return const _ScrollableWrapper(
                      child: NotificationsEmptyBody(),
                    );
                  }
                  return NotificationsList(notifications: response.data);
                },
                loading: () => _ScrollableWrapper(
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: CircularProgressIndicator(
                        color: Palette.petrolBlue,
                      ),
                    ),
                  ),
                ),
                error: (_, __) => _ScrollableWrapper(
                  child: NotificationsErrorBody(
                    message: tr.common_error,
                    btnText: tr.retry,
                    onRetry: () => ref.invalidate(getNotificationsProvider),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Wrapper scrollable — nécessaire pour que RefreshIndicator
// fonctionne même sur les états loading/error/empty (pas de liste réelle).
// ─────────────────────────────────────────────

class _ScrollableWrapper extends StatelessWidget {
  const _ScrollableWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: child,
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// Header
// ─────────────────────────────────────────────

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(
          children: [
            const RoundedBackButton(),
            const Gap(12),
            Text(
              tr.notifications,
              style: FontsStyles.bold.copyWith(
                fontSize: 18,
                color: Palette.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Liste groupée par jour
// ─────────────────────────────────────────────

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key, required this.notifications});

  final List<NotificationModel> notifications;

  Map<String, List<NotificationModel>> _groupByDay(AppLocalizations tr) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final grouped = <String, List<NotificationModel>>{};

    for (final notification in notifications) {
      final date = notification.createdAt;
      final day = DateTime(date.year, date.month, date.day);

      final String label;
      if (day == today) {
        label = "today";
      } else if (day == yesterday) {
        label = "yesterda";
      } else {
        label =
            '${date.day.toString().padLeft(2, '0')}/'
            '${date.month.toString().padLeft(2, '0')}/'
            '${date.year}';
      }

      grouped.putIfAbsent(label, () => []).add(notification);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final grouped = _groupByDay(tr);
    final sections = grouped.entries.toList();

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        16,
        4,
        16,
        MediaQuery.of(context).padding.bottom + 24,
      ),
      itemCount: sections.length,
      itemBuilder: (context, sectionIndex) {
        final section = sections[sectionIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(4, sectionIndex == 0 ? 8 : 20, 4, 8),
              child: Text(
                section.key,
                style: FontsStyles.medium.copyWith(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            for (var i = 0; i < section.value.length; i++)
              NotificationTile(
                notification: section.value[i],
                showDivider: i != section.value.length - 1,
              ),
          ],
        );
      },
    );
  }
}

// ─────────────────────────────────────────────
// Tile
// ─────────────────────────────────────────────

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.showDivider,
  });

  final NotificationModel notification;
  final bool showDivider;

  Color get accentColor {
    switch (notification.type) {
      case 'TRANSACTION_RECEIVED':
        return Palette.teal;
      case 'TRANSACTION_SENT':
        return Palette.orange;
      case 'TRANSACTION_DEPOSIT':
        return Palette.petrolBlue;
      case 'TRANSACTION_WITHDRAWAL':
        return Palette.goldYellow;
      default:
        return Colors.grey.shade400;
    }
  }

  IconData get accentIcon {
    switch (notification.type) {
      case 'TRANSACTION_RECEIVED':
        return Icons.south_west_rounded;
      case 'TRANSACTION_SENT':
        return Icons.north_east_rounded;
      case 'TRANSACTION_DEPOSIT':
        return Icons.add_rounded;
      case 'TRANSACTION_WITHDRAWAL':
        return Icons.south_rounded;
      default:
        return Icons.notifications_outlined;
    }
  }

  String resolveTitle(AppLocalizations tr) {
    switch (notification.type) {
      case 'TRANSACTION_RECEIVED':
        return tr.notif_received(
          notification.data.amount,
          notification.data.currency,
          notification.data.name,
        );
      case 'TRANSACTION_SENT':
        return tr.notif_sent(
          notification.data.amount,
          notification.data.currency,
          notification.data.name,
        );
      case 'TRANSACTION_DEPOSIT':
        return tr.notif_deposit(
          notification.data.amount,
          notification.data.currency,
          notification.data.name,
        );
      case 'TRANSACTION_WITHDRAWAL':
        return tr.notif_withdrawal(
          notification.data.amount,
          notification.data.currency,
          notification.data.name,
        );
      default:
        return notification.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final isUnread = !notification.isRead;

    return Container(
      decoration: BoxDecoration(
        border: showDivider
            ? Border(bottom: BorderSide(color: Colors.grey.shade100, width: 1))
            : null,
      ),
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(accentIcon, size: 18, color: accentColor),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resolveTitle(tr),
                  style: isUnread
                      ? FontsStyles.medium.copyWith(
                          fontSize: 14,
                          color: Palette.black,
                          height: 1.4,
                        )
                      : FontsStyles.regular.copyWith(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                          height: 1.4,
                        ),
                ),
                const Gap(3),
                Text(
                  GetTimeAgo.parse(notification.createdAt),
                  style: FontsStyles.regular.copyWith(
                    fontSize: 12,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          if (isUnread)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: Palette.petrolBlue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Body vide
// ─────────────────────────────────────────────

class NotificationsEmptyBody extends StatelessWidget {
  const NotificationsEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_off_outlined,
                size: 28,
                color: Colors.grey.shade400,
              ),
            ),
            const Gap(16),
            Text(
              tr.noNotifications,
              style: FontsStyles.bold.copyWith(
                fontSize: 16,
                color: Palette.black,
              ),
            ),
            const Gap(6),
            Text(
              tr.notificationsEmptyDescription,
              style: FontsStyles.regular.copyWith(
                fontSize: 13,
                color: Colors.grey.shade400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Body erreur
// ─────────────────────────────────────────────

class NotificationsErrorBody extends StatelessWidget {
  const NotificationsErrorBody({
    super.key,
    required this.message,
    required this.btnText,
    required this.onRetry,
  });

  final String message;
  final String btnText;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 28,
                color: Colors.red.withOpacity(0.6),
              ),
            ),
            const Gap(16),
            Text(
              message,
              style: FontsStyles.regular.copyWith(
                color: Palette.black,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            GestureDetector(
              onTap: onRetry,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 13,
                ),
                decoration: BoxDecoration(
                  color: Palette.petrolBlue,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  btnText,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 14,
                    color: Palette.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
