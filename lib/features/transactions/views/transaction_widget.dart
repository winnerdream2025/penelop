import 'package:corrispay/app/design/fonts_styles.dart';
import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/transactions/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/providers/language_provider.dart';
import '../../bases/widgets/default_button.dart';

const _petrol = Palette.petrolBlue;

// ─────────────────────────────────────────────
// Bouton retour rond — partagé (inchangé)
// ─────────────────────────────────────────────

class RoundedBackButton extends StatelessWidget {
  const RoundedBackButton({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade100,
        ),
        child: const Icon(Icons.arrow_back, size: 18, color: Colors.black87),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Header (inchangé)
// ─────────────────────────────────────────────

class TransactionsHeader extends StatelessWidget {
  const TransactionsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Row(
        children: [
          RoundedBackButton(onTap: () => Navigator.pop(context)),
          const Gap(14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr.transactions,
                style: FontsStyles.bold.copyWith(
                  fontSize: 16,
                  color: Colors.black,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                tr.history,
                style: FontsStyles.regular.copyWith(
                  fontSize: 11,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Liste groupée par mois (inchangée)
// ─────────────────────────────────────────────

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
    required this.transactions,
    required this.currency,
    required this.exchangeRate,
  });

  final List<Transaction> transactions;
  final String currency;
  final double exchangeRate;

  Map<String, List<Transaction>> get groupedByMonth {
    final map = <String, List<Transaction>>{};
    for (final t in transactions) {
      final key = DateFormat('MMMM yyyy').format(t.date).toUpperCase();
      map.putIfAbsent(key, () => []).add(t);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final groups = groupedByMonth;
    return ListView(
      padding: const EdgeInsets.only(top: 16, bottom: 32),
      children: groups.entries.expand((entry) {
        return [
          TransactionsMonthSeparator(label: entry.key),
          const Gap(8),
          ...entry.value.map(
                (t) => TransactionTile(
              transaction: t,
              currency: currency,
              exchangeRate: exchangeRate,
            ),
          ),
          const Gap(8),
        ];
      }).toList(),
    );
  }
}

// ─────────────────────────────────────────────
// Séparateur de mois (inchangé)
// ─────────────────────────────────────────────

class TransactionsMonthSeparator extends StatelessWidget {
  const TransactionsMonthSeparator({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: FontsStyles.bold.copyWith(
              fontSize: 10,
              color: Colors.grey.shade400,
              letterSpacing: 1.0,
            ),
          ),
          const Gap(10),
          Expanded(
            child: Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey.shade100,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Tile transaction — REDESIGNÉE avec isSent
// ─────────────────────────────────────────────

class TransactionTile extends ConsumerWidget {
  const TransactionTile({
    super.key,
    required this.transaction,
    required this.currency,
    required this.exchangeRate,
  });

  final Transaction transaction;
  final String currency;
  final double exchangeRate;

  bool get isSuccess => transaction.statut == 'SUCCESS';

  /// Plus de switch fragile sur le texte du type — directement basé
  /// sur isSent, fourni par le backend pour CHAQUE type de
  /// transaction (dépôt, retrait, transfert, paiement, ajustement).
  bool get isCredit => !transaction.isSent;

  Color get accentColor => isSuccess ? _petrol : const Color(0xFFE04040);

  Color get iconBgColor =>
      isSuccess ? const Color(0xFFF4FAF9) : const Color(0xFFFFF0F0);

  /// SEULEMENT 2 icônes possibles maintenant — flèche sortante si
  /// envoyé, entrante si reçu. Beaucoup plus simple et fiable que
  /// deviner à partir du texte du type (accents, casse, nouveaux
  /// types futurs non prévus dans un switch...).
  IconData get icon {
    if (!isSuccess) return Icons.close_rounded;
    return transaction.isSent
        ? Icons.arrow_outward_rounded
        : Icons.arrow_downward_rounded;
  }

  /// Le LABEL textuel reste basé sur `type` (le backend envoie déjà
  /// un texte prêt à afficher : "Dépôt", "Retrait", "Envoyé", "Reçu",
  /// "Payé", "Paiement reçu", "Ajustement"...). Pas de switch de
  /// traduction ici — le texte vient du backend tel quel.
  String get typeLabel => transaction.type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProviderState);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesNames.transactionDetailView, arguments: transaction);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFF5F5F5), width: 0.5),
          ),
        ),
        child: Row(
          children: [
            // ── Icône ─────────────────────────────────────────
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: accentColor.withOpacity(0.10),
                  width: 0.5,
                ),
              ),
              child: Icon(icon, color: accentColor, size: 20),
            ),
            const Gap(12),
            // ── Infos ─────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.name,
                    style: FontsStyles.bold.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(3),
                  Text(
                    GetTimeAgo.parse(
                      transaction.date,
                      locale: locale.locale.toString(),
                    ),
                    style: FontsStyles.regular.copyWith(
                      fontSize: 11,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(12),
            // ── Montant ───────────────────────────────────────
            _TransactionAmount(
              montant: transaction.montant,
              currency: currency,
              typeLabel: typeLabel,
              accentColor: accentColor,
              isCredit: isCredit,
              isSuccess: isSuccess,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Montant + badge type (inchangé, sauf typeLabel qui vient
// maintenant directement du backend au lieu d'un switch local)
// ─────────────────────────────────────────────

class _TransactionAmount extends StatelessWidget {
  const _TransactionAmount({
    required this.montant,
    required this.currency,
    required this.typeLabel,
    required this.accentColor,
    required this.isCredit,
    required this.isSuccess,
  });

  final double montant;
  final String currency;
  final String typeLabel;
  final Color accentColor;
  final bool isCredit;
  final bool isSuccess;

  String get formattedAmount {
    final prefix = isCredit && isSuccess ? '+ ' : '- ';
    final formatted = NumberFormat('#,###', 'fr_FR').format(montant);
    return '$prefix$formatted';
  }

  Color get amountColor => isCredit && isSuccess ? _petrol : Colors.black;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              formattedAmount,
              style: FontsStyles.bold.copyWith(
                fontSize: 15,
                color: amountColor,
              ),
            ),
            const Gap(3),
            Text(
              currency,
              style: FontsStyles.regular.copyWith(
                fontSize: 11,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
        const Gap(4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.09),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            typeLabel,
            style: FontsStyles.bold.copyWith(
              fontSize: 10,
              color: accentColor,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// État vide (inchangé)
// ─────────────────────────────────────────────

class TransactionsEmptyBody extends StatelessWidget {
  const TransactionsEmptyBody({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFFF4FAF9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _petrol.withOpacity(0.12),
                width: 0.5,
              ),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: _petrol,
              size: 28,
            ),
          ),
          const Gap(16),
          Text(
            tr.no_transactions,
            style: FontsStyles.bold.copyWith(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const Gap(6),
          Text(
            tr.no_transactions_desc,
            style: FontsStyles.regular.copyWith(
              fontSize: 13,
              color: Colors.grey.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// État erreur (inchangé)
// ─────────────────────────────────────────────

class TransactionsErrorBody extends StatelessWidget {
  const TransactionsErrorBody({
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
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0F0),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                color: Color(0xFFE04040),
                size: 26,
              ),
            ),
            const Gap(16),
            Text(
              message,
              style: FontsStyles.regular.copyWith(
                color: Colors.black,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(24),
            DefaultButton(
              bgColor: _petrol,
              hPadding: 16,
              text: btnText,
              onTap: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}