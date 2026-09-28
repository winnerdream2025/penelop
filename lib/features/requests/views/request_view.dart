import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/requests/views/widgets/request_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../bases/services/service.dart';
import '../models/user-request.model.dart';
import '../providers/user-request.provider.dart';

class RequestsView extends ConsumerStatefulWidget {
  const RequestsView({super.key});

  @override
  ConsumerState<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends ConsumerState<RequestsView> {
  final _socketService = SocketService();

  @override
  void initState() {
    super.initState();
    _listenToSocket();
  }

  void _listenToSocket() {
    _socketService.listenNewRequest((data) {
      print("object");
      print(data);
      try {
        print(data);
        final request = UserRequest.fromJson(Map<String, dynamic>.from(data));
        ref.read(userRequestsNotifierProvider.notifier).addRequest(request);
      } catch (e) {
        print('Erreur parsing newRequest: $e');
      }
    });

    _socketService.listenRequestRemoved((data) {
      try {
        final id = data['id'] as String;
        ref.read(userRequestsNotifierProvider.notifier).removeRequest(id);
      } catch (e) {
        print('Erreur parsing requestRemoved: $e');
      }
    });
  }

  @override
  void dispose() {
    _socketService.stopListeningNewRequest();
    _socketService.stopListeningRequestRemoved();
    super.dispose();
  }

  // ── Plus d'état local _processingIds ici — tout vient du provider,
  // qui gère déjà correctement le "en cours" pendant l'appel réseau. ──

  Future<void> _handleValidate(UserRequest request) async {
    // TODO: route vers ConfirmRequestView (écran PIN dédié), pas
    // directement un appel ici — cette carte sert juste de point
    // d'entrée vers cet écran.
    Navigator.pushNamed(
      context,
      RoutesNames.confirmRequestView,
      arguments: request,
    );
  }

  Future<void> _handleReject(UserRequest request) async {
    await ref
        .read(userRequestsNotifierProvider.notifier)
        .rejectRequest(request.id);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userRequestsNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              Text(
                'Demandes',
                style: FontsStyles.medium.copyWith(
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                state.requests.isEmpty
                    ? 'Aucune demande en attente'
                    : '${state.requests.length} en attente de votre reponse',
                style: FontsStyles.regular.copyWith(
                  fontSize: 12,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 18),

              Expanded(child: _buildBody(state)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(UserRequestsState state) {
    if (state.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF00616B),
          strokeWidth: 2,
        ),
      );
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.errorMessage!,
              style: FontsStyles.regular.copyWith(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () =>
                  ref.read(userRequestsNotifierProvider.notifier).refresh(),
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    if (state.requests.isEmpty) {
      return Center(
        child: Text(
          'Vos demandes de paiement et de retrait\napparaîtront ici.',
          textAlign: TextAlign.center,
          style: FontsStyles.regular.copyWith(
            fontSize: 13,
            color: Colors.grey.shade400,
            height: 1.5,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: state.requests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final request = state.requests[index];
        return RequestCard(
          request: request,
          // ── Vient directement du state du provider — plus jamais
          // désynchronisé, plus besoin de gérer ça localement. ──
          loading: state.isProcessing(request.id),
          onReject: () => _handleReject(request),
          onValidate: () => _handleValidate(request),
        );
      },
    );
  }
}
