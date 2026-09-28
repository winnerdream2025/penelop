import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:corrispay/features/transactions/models/transaction.dart';
import 'package:riverpod/legacy.dart';
import '../repositories/transaction_repository.dart'; // adapte le chemin réel vers TransactionRepository

// ─────────────────────────────────────────────
// État — inchangé
// ─────────────────────────────────────────────

class TransactionsState {
  final List<Transaction> items;
  final bool isLoadingInitial;
  final bool isLoadingMore;
  final bool hasMore;
  final int currentPage;
  final String? errorMessage;

  const TransactionsState({
    this.items = const [],
    this.isLoadingInitial = true,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.currentPage = 0,
    this.errorMessage,
  });

  TransactionsState copyWith({
    List<Transaction>? items,
    bool? isLoadingInitial,
    bool? isLoadingMore,
    bool? hasMore,
    int? currentPage,
    String? errorMessage,
  }) {
    return TransactionsState(
      items: items ?? this.items,
      isLoadingInitial: isLoadingInitial ?? this.isLoadingInitial,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage,
    );
  }
}

// ─────────────────────────────────────────────
// Notifier — utilise maintenant TransactionRepository via `ref`
// ─────────────────────────────────────────────

class TransactionsNotifier extends StateNotifier<TransactionsState> {
  TransactionsNotifier(this._ref) : super(const TransactionsState()) {
    loadInitial();
  }

  final Ref _ref;
  static const int _limit = 20;

  Future<void> loadInitial() async {
    state = state.copyWith(
      isLoadingInitial: true,
      errorMessage: null,
      items: [],
      currentPage: 0,
      hasMore: true,
    );

    final repo = _ref.read(transactionRepositoryProvider);
    final response = await repo.getTransactions(page: 1, limit: _limit);

    if (response == null || !response.status || response.data == null) {
      state = state.copyWith(
        isLoadingInitial: false,
        errorMessage: response?.message ?? 'common_error',
      );
      return;
    }

    state = state.copyWith(
      items: response.data!.items,
      isLoadingInitial: false,
      hasMore: response.data!.hasMore,
      currentPage: response.data!.page,
      errorMessage: null,
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore || state.isLoadingInitial) return;

    state = state.copyWith(isLoadingMore: true);

    final repo = _ref.read(transactionRepositoryProvider);
    final nextPage = state.currentPage + 1;
    final response = await repo.getTransactions(page: nextPage, limit: _limit);

    if (response == null || !response.status || response.data == null) {
      state = state.copyWith(isLoadingMore: false);
      return;
    }

    state = state.copyWith(
      items: [...state.items, ...response.data!.items],
      isLoadingMore: false,
      hasMore: response.data!.hasMore,
      currentPage: response.data!.page,
    );
  }

  Future<void> refresh() => loadInitial();
}

// ─────────────────────────────────────────────
// Provider — `ref` transmis au notifier pour qu'il puisse lire
// transactionRepositoryProvider à chaque appel.
// ─────────────────────────────────────────────

final transactionsNotifierProvider =
StateNotifierProvider<TransactionsNotifier, TransactionsState>(
      (ref) => TransactionsNotifier(ref),
);