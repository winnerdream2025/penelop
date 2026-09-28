import 'package:corrispay/app/utils/app_urls.dart';
import 'package:corrispay/core/local/userlocal_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  late IO.Socket mainSocket; // caurispay-backend (retraits, balance, transactions)
  late IO.Socket merchantSocket; // caurispay-merchant-api (paiements)

  bool _isMainConnected = false;
  bool _isMerchantConnected = false;

  Future<void> connect() async {
    final token = UserUtils.getToken();

    if (!_isMainConnected) {
      mainSocket = IO.io(AppUrls.serverUrl, {
        'transports': ['websocket'],
        'auth': {'token': token},
        'autoConnect': false,
      });

      mainSocket.connect();

      mainSocket.onConnect((_) {
        _isMainConnected = true;
        print('✅ Connecté au serveur principal');
      });

      mainSocket.onConnectError((err) {
        _isMainConnected = false;
        print('🚫 Erreur de connexion (principal): $err');
      });

      mainSocket.onDisconnect((_) {
        _isMainConnected = false;
        print('❌ Déconnecté (principal)');
      });
    }

    if (!_isMerchantConnected) {
      merchantSocket = IO.io(AppUrls.merchantApiUrl, {
        'transports': ['websocket'],
        'auth': {'token': token},
        'autoConnect': false,
      });

      merchantSocket.connect();

      merchantSocket.onConnect((_) {
        _isMerchantConnected = true;
        print('✅ Connecté au serveur marchand');
      });

      merchantSocket.onConnectError((err) {
        _isMerchantConnected = false;
        print('🚫 Erreur de connexion (marchand): $err');
      });

      merchantSocket.onDisconnect((_) {
        _isMerchantConnected = false;
        print('❌ Déconnecté (marchand)');
      });
    }
  }

  void listenBalance(Function(dynamic) callback) {
    mainSocket.off('balanceUpdated');
    mainSocket.on('balanceUpdated', callback);
  }

  void watchTransaction(String reference) {
    mainSocket.emit('watchTransaction', reference);
  }

  void unwatchTransaction(String reference) {
    mainSocket.emit('unwatchTransaction', reference);
  }

  void listenTransactionStatus(Function(dynamic) callback) {
    mainSocket.off('transactionStatus');
    mainSocket.on('transactionStatus', callback);
  }

  void stopListeningTransactionStatus() {
    mainSocket.off('transactionStatus');
  }

  void listenNewTransactions(Function(dynamic) callback) {
    mainSocket.off('newTransaction');
    mainSocket.on('newTransaction', callback);
  }

  void stopListeningNewTransactions() {
    mainSocket.off('newTransaction');
  }

  // ─── Demandes (paiement + retrait) — ÉCOUTE SUR LES DEUX SOCKETS ────────────
  void listenNewRequest(Function(dynamic) callback) {
    mainSocket.off('newRequest');
    mainSocket.on('newRequest', callback);

    merchantSocket.off('newRequest');
    merchantSocket.on('newRequest', callback);
  }

  void stopListeningNewRequest() {
    mainSocket.off('newRequest');
    merchantSocket.off('newRequest');
  }

  void listenRequestRemoved(Function(dynamic) callback) {
    mainSocket.off('requestRemoved');
    mainSocket.on('requestRemoved', callback);

    merchantSocket.off('requestRemoved');
    merchantSocket.on('requestRemoved', callback);
  }

  void stopListeningRequestRemoved() {
    mainSocket.off('requestRemoved');
    merchantSocket.off('requestRemoved');
  }

  void dispose() {
    // Ne rien faire ici — le singleton reste en vie
  }

  void disconnect() {
    mainSocket.disconnect();
    mainSocket.dispose();
    _isMainConnected = false;

    merchantSocket.disconnect();
    merchantSocket.dispose();
    _isMerchantConnected = false;
  }

  void listenMerchantBalance(Function(dynamic) callback) {
    mainSocket.off('merchantBalanceUpdated');
    mainSocket.on('merchantBalanceUpdated', callback);
  }

  void stopListeningMerchantBalance() {
    mainSocket.off('merchantBalanceUpdated');
  }
}