class QrCodeResponse {
  final String amount;
  final String customerId;

  const QrCodeResponse({required this.amount, required this.customerId});
}

enum OperationType {
  WITHDRAWAL,
  RECHARGE,
}
