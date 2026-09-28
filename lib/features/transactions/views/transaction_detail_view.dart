import 'package:corrispay/app/design/palette.dart';
import 'package:corrispay/features/transactions/models/transaction.dart';
import 'package:corrispay/features/transactions/views/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../l10n/app_localizations.dart';


class TransactionDetailView extends ConsumerWidget {
  const TransactionDetailView({super.key, required this.transaction});

  final Transaction transaction;

  bool get isSuccess => transaction.statut == 'SUCCESS';
  bool get isCredit {
    final t = transaction.type.toLowerCase();
    return t == 'dépôt' || t == 'depot' || t == 'reçu' || t == 'recu';
  }

  Color get accentColor => isSuccess ? Palette.petrolBlue : const Color(0xFFE04040);
  Color get iconBgColor =>
      isSuccess ? const Color(0xFFF4FAF9) : const Color(0xFFFFF0F0);

  IconData get icon {
    if (!isSuccess) return Icons.close_rounded;
    switch (transaction.type.toLowerCase()) {
      case 'depot':
      case 'dépôt':
        return Icons.add_circle_outline_rounded;
      case 'recu':
      case 'reçu':
        return Icons.south_west_rounded;
      case 'retrait':
        return Icons.account_balance_wallet_outlined;
      default:
        return Icons.north_east_rounded;
    }
  }

  String _translatedType(AppLocalizations tr) {
    switch (transaction.type.toLowerCase()) {
      case 'depot':
      case 'dépôt':
        return tr.tx_deposit;
      case 'recu':
      case 'reçu':
        return tr.tx_received;
      case 'retrait':
        return tr.tx_withdrawal;
      default:
        return tr.tx_sent;
    }
  }

  String _formattedAmount(bool credit) {
    final prefix = credit && isSuccess ? '+ ' : '- ';
    return '$prefix${NumberFormat('#,###', 'fr_FR').format(transaction.montant)}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tr = AppLocalizations.of(context)!;
    final user = ref.watch(userLocalProvider);
    final currency = user?.targetCurrency ?? '';
    final formattedDate = DateFormat(
      'dd MMM yyyy · HH:mm',
      Localizations.localeOf(context).toString(),
    ).format(transaction.date);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.5),
            child: Container(color: const Color(0xFFF0F0F0), height: 0.5),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: RoundedBackButton(
              onTap: () => Navigator.pop(context),
            ),
          ),
          title: Text(
            tr.transaction_detail,
            style: FontsStyles.bold.copyWith(
              color: Colors.black,
              fontSize: 16,
              letterSpacing: -0.3,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Hero montant ─────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: accentColor.withOpacity(0.12),
                    width: 0.5,
                  ),
                ),
                child: Column(
                  children: [
                    // Icône
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(icon, color: Colors.white, size: 24),
                    ),
                    const Gap(10),
                    // Label type
                    Text(
                      _translatedType(tr).toUpperCase(),
                      style: FontsStyles.bold.copyWith(
                        fontSize: 10,
                        color: accentColor,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const Gap(8),
                    // Montant
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          _formattedAmount(isCredit),
                          style: FontsStyles.bold.copyWith(
                            fontSize: 36,
                            color: Colors.black,
                            letterSpacing: -2,
                            height: 1,
                          ),
                        ),
                        const Gap(6),
                        Text(
                          currency,
                          style: FontsStyles.regular.copyWith(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    const Gap(12),
                    // Badge statut
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSuccess
                                ? Icons.check_circle_outline_rounded
                                : Icons.cancel_outlined,
                            size: 12,
                            color: accentColor,
                          ),
                          const Gap(5),
                          Text(
                            isSuccess ? tr.tx_success : tr.tx_failed,
                            style: FontsStyles.bold.copyWith(
                              fontSize: 11,
                              color: accentColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Gap(20),

              // ── Section infos ────────────────────────────────
              _SectionLabel(label: tr.tx_detail_info),
              const Gap(8),
              _InfoCard(
                rows: [
                  _InfoRow(label: tr.tx_detail_name, value: transaction.name),
                  _InfoRow(label: tr.tx_detail_date, value: formattedDate),
                  _InfoRow(
                    label: tr.tx_detail_type,
                    value: _translatedType(tr),
                  ),
                  _InfoRow(
                    label: tr.tx_detail_status,
                    value: isSuccess ? tr.tx_success : tr.tx_failed,
                    valueColor: accentColor,
                  ),
                ],
              ),

              const Gap(20),

              // ── Section référence ─────────────────────────────
              _SectionLabel(label: tr.tx_detail_reference),
              const Gap(8),
              _ReferenceCard(
                reference: transaction.reference ?? tr.tx_no_reference,
                copyLabel: tr.copy,
                copiedLabel: tr.copied,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Label de section
// ─────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: FontsStyles.bold.copyWith(
        fontSize: 10,
        color: Colors.grey.shade400,
        letterSpacing: 1.2,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Card infos
// ─────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.rows});
  final List<_InfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEBEBEB), width: 0.5),
      ),
      child: Column(
        children: rows
            .asMap()
            .entries
            .map((e) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    e.value.label,
                    style: FontsStyles.regular.copyWith(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Text(
                    e.value.value,
                    style: FontsStyles.bold.copyWith(
                      fontSize: 13,
                      color: e.value.valueColor ?? Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            if (e.key < rows.length - 1)
              Divider(
                height: 0.5,
                thickness: 0.5,
                color: Colors.grey.shade100,
                indent: 14,
                endIndent: 14,
              ),
          ],
        ))
            .toList(),
      ),
    );
  }
}

class _InfoRow {
  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
  });
  final String label;
  final String value;
  final Color? valueColor;
}

// ─────────────────────────────────────────────
// Card référence avec bouton copier
// ─────────────────────────────────────────────

class _ReferenceCard extends StatefulWidget {
  const _ReferenceCard({
    required this.reference,
    required this.copyLabel,
    required this.copiedLabel,
  });
  final String reference;
  final String copyLabel;
  final String copiedLabel;

  @override
  State<_ReferenceCard> createState() => _ReferenceCardState();
}

class _ReferenceCardState extends State<_ReferenceCard> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.reference));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEBEBEB), width: 0.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.reference,
              style: FontsStyles.regular.copyWith(
                fontSize: 12,
                color: Colors.black,
                fontFeatures: const [FontFeature.tabularFigures()],
                letterSpacing: 0.3,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Gap(12),
          GestureDetector(
            onTap: _copy,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _copied
                    ? Palette.petrolBlue.withOpacity(0.12)
                    : const Color(0xFFF4FAF9),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Palette.petrolBlue.withOpacity(0.18),
                  width: 0.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _copied
                        ? Icons.check_rounded
                        : Icons.copy_outlined,
                    size: 13,
                    color: Palette.petrolBlue,
                  ),
                  const Gap(5),
                  Text(
                    _copied ? widget.copiedLabel : widget.copyLabel,
                    style: FontsStyles.bold.copyWith(
                      fontSize: 11,
                      color:Palette.petrolBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}