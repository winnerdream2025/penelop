import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/features/transactions/views/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/local/userlocal_provider.dart';
import '../providers/get-transactions.provider.dart';

class TransactionsView extends ConsumerWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = AppLocalizations.of(context)!;
    final state = ref.watch(transactionsNotifierProvider);
    final notifier = ref.read(transactionsNotifierProvider.notifier);
    final user = ref.watch(userLocalProvider);
    final topPad = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20).copyWith(top: topPad),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TransactionsHeader(),
              const Gap(4),
              Container(height: 0.5, color: const Color(0xFFF0F0F0)),
              const Gap(4),
              Expanded(child: _buildBody(context, tr, state, notifier, user)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    AppLocalizations tr,
    TransactionsState state,
    TransactionsNotifier notifier,
    dynamic user,
  ) {
    if (state.isLoadingInitial) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF1A7A6E),
          strokeWidth: 2,
        ),
      );
    }

    if (state.errorMessage != null) {
      return TransactionsErrorBody(
        message: tr.common_error,
        btnText: tr.retry,
        onRetry: () => notifier.loadInitial(),
      );
    }

    if (state.items.isEmpty) {
      return const TransactionsEmptyBody();
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        final nearBottom = metrics.pixels >= metrics.maxScrollExtent - 200;

        if (nearBottom) {
          notifier.loadMore();
        }
        return false;
      },
      child: RefreshIndicator(
        color: Palette.petrolBlue,
        onRefresh: () => notifier.refresh(),
        child: Column(
          children: [
            Expanded(
              child: TransactionsList(
                transactions: state.items,
                currency: user?.targetCurrency ?? '',
                exchangeRate: user?.currencyRate ?? 1.0,
              ),
            ),
            if (state.isLoadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    color: Color(0xFF1A7A6E),
                    strokeWidth: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
