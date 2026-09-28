import 'dart:async';
import 'package:corrispay/core/api_responses/api_response.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:corrispay/features/requests/models/user-request.model.dart';
import 'package:corrispay/features/requests/dto/confirm-request.dto.dart';
import 'package:riverpod/legacy.dart';

import '../repostories/user-request.repository.dart'; // adapte le chemin réel

class UserRequestsState {
  final List<UserRequest> requests;
  final bool loading;
  final String? errorMessage;
  final int tick;
  final Set<String> processingIds;

  const UserRequestsState({
    this.requests = const [],
    this.loading = true,
    this.errorMessage,
    this.tick = 0,
    this.processingIds = const {},
  });

  UserRequestsState copyWith({
    List<UserRequest>? requests,
    bool? loading,
    String? errorMessage,
    int? tick,
    Set<String>? processingIds,
  }) {
    return UserRequestsState(
      requests: requests ?? this.requests,
      loading: loading ?? this.loading,
      errorMessage: errorMessage,
      tick: tick ?? this.tick,
      processingIds: processingIds ?? this.processingIds,
    );
  }

  bool isProcessing(String requestId) => processingIds.contains(requestId);
}

class UserRequestsNotifier extends StateNotifier<UserRequestsState> {
  UserRequestsNotifier(this._ref) : super(const UserRequestsState()) {
    _loadRequests();

    _tickTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tick();
    });
  }

  final Ref _ref;
  Timer? _tickTimer;

  Future<void> _loadRequests() async {
    state = state.copyWith(loading: true, errorMessage: null);

    final repo = _ref.read(userRequestRepositoryProvider);
    final response = await repo.getMyRequests();

    if (response == null || !response.status) {
      state = state.copyWith(
        loading: false,
        errorMessage: response?.message ?? 'common_error',
      );
      return;
    }

    state = state.copyWith(
      requests: response.data ?? [],
      loading: false,
      errorMessage: null,
    );
  }

  void _tick() {
    final now = DateTime.now();
    final stillValid = state.requests
        .where((r) => r.expiresAt.isAfter(now))
        .toList();

    state = state.copyWith(requests: stillValid, tick: state.tick + 1);
  }

  void addRequest(UserRequest request) {
    if (state.requests.any((r) => r.id == request.id)) return;
    state = state.copyWith(requests: [...state.requests, request]);
  }

  void removeRequest(String requestId) {
    state = state.copyWith(
      requests: state.requests.where((r) => r.id != requestId).toList(),
    );
  }

  Future<void> refresh() => _loadRequests();

  void _setProcessing(String requestId, bool processing) {
    final updated = Set<String>.from(state.processingIds);
    if (processing) {
      updated.add(requestId);
    } else {
      updated.remove(requestId);
    }
    state = state.copyWith(processingIds: updated);
  }

  /// Renvoie `null` en cas de succès, ou le message d'erreur du
  /// backend sinon. `processingIds` reflète l'état pendant toute la
  /// durée de l'appel.
  Future<ApiResponse?> confirmRequest(String requestId, String pin) async {
    _setProcessing(requestId, true);

    final repo = _ref.read(userRequestRepositoryProvider);
    final dto = ConfirmRequestDto(requestId: requestId, pin: pin);
    final response = await repo.confirmRequest(dto);

    if (response != null && response.status) {
      removeRequest(requestId);
    }
    _setProcessing(requestId, false);
    return response;
  }

  /// Renvoie `true` en cas de succès, `false` sinon.
  Future<bool> rejectRequest(String requestId) async {
    _setProcessing(requestId, true);

    try {
      final repo = _ref.read(userRequestRepositoryProvider);
      final response = await repo.rejectRequest(requestId);

      if (response == null || !response.status) {
        return false;
      }

      removeRequest(requestId);
      return true;
    } finally {
      _setProcessing(requestId, false);
    }
  }

  @override
  void dispose() {
    _tickTimer?.cancel();
    super.dispose();
  }
}

final userRequestsNotifierProvider =
    StateNotifierProvider<UserRequestsNotifier, UserRequestsState>(
      (ref) => UserRequestsNotifier(ref),
    );
