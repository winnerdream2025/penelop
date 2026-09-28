/// Représente le numéro de réception choisi pour un retrait mobile
/// money — soit un contact du téléphone, soit un numéro tapé
/// manuellement (auquel cas [name] est `null`).
class MobileMoneyRecipient {
  const MobileMoneyRecipient({this.name, required this.phoneNumber});

  final String? name;
  final String phoneNumber;

  String get initials {
    if (name == null || name!.trim().isEmpty) return '#';
    final parts = name!.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  String get displayName => name ?? phoneNumber;
}