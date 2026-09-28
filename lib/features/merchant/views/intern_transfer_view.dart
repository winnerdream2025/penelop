import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/core/utils/functions.dart';
import 'package:corrispay/features/bases/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../dto/transfer-between-accounts.dart';
import '../models/account-data.dart';
import '../providers/merchant.provider.dart';

class TransferView extends ConsumerStatefulWidget {
  const TransferView({super.key});

  @override
  ConsumerState<TransferView> createState() => _TransferViewState();
}

class _TransferViewState extends ConsumerState<TransferView> {
  final _amountController = TextEditingController();

  // ── Directement TransferDirection maintenant — plus besoin de
  // convertir un enum "interne" vers celui du DTO au moment de
  // soumettre. null = pas encore choisi. ──
  TransferDirection? _direction;
  bool _loading = false;
  String? _errorMessage;

  // ── Dans _TransferViewState, ajoute initState ──

  @override
  void initState() {
    super.initState();

    // ── Ceinture et bretelles — même avec .autoDispose sur le
    // provider, force une VRAIE invalidation dès l'ouverture de
    // l'écran, garantissant un appel réseau frais à chaque fois. ──
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(getAccountsProvider);
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String _formatAmount(double value) {
    return value.toInt().toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]} ',
    );
  }

  bool get _isFromPersonal =>
      _direction == TransferDirection.personalToMerchant;

  void _pickFromAccount(TransferAccountsData accounts) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choisir le compte source',
                style: FontsStyles.bold.copyWith(
                  fontSize: 16,
                  color: Palette.black,
                ),
              ),
              const SizedBox(height: 16),
              _AccountOption(
                label: accounts.personalAccount.name,
                typeLabel: 'Personnel',
                balance: accounts.personalAccount.balance,
                onTap: () {
                  setState(() {
                    _direction = TransferDirection.personalToMerchant;
                    _errorMessage = null;
                  });
                  Navigator.pop(context);
                },
              ),
              if (accounts.merchantAccount != null) ...[
                const SizedBox(height: 10),
                _AccountOption(
                  label: accounts.merchantAccount!.name,
                  typeLabel: 'Marchand',
                  balance: accounts.merchantAccount!.balance,
                  onTap: () {
                    setState(() {
                      _direction = TransferDirection.merchantToPersonal;
                      _errorMessage = null;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit(TransferAccountsData accounts) async {
    if (_direction == null) {
      setState(() => _errorMessage = 'Choisissez un compte source.');
      return;
    }

    final amount = double.tryParse(_amountController.text.replaceAll(' ', ''));
    if (amount == null || amount <= 0) {
      setState(() => _errorMessage = 'Entrez un montant valide.');
      return;
    }

    final fromBalance = _isFromPersonal
        ? accounts.personalAccount.balance
        : accounts.merchantAccount!.balance;

    if (amount > fromBalance) {
      setState(() => _errorMessage = 'Solde insuffisant sur le compte source.');
      return;
    }

    showLoading();

    final result = await ref.read(
      internTransferProvider(
        TransferBetweenAccountsDto(
          amount:
              double.tryParse(_amountController.text.replaceAll(' ', '')) ?? 0,
          direction: _direction!,
        ),
      ).future,
    );

    if (result != null && result.data != null && result.status) {
      hideLoading();
      showSuccessMessage(result.message);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesNames.verificationCodeCompleted,
        (route) => false,
        arguments: result.data,
      );
    } else {
      hideLoading();
      showErrorMessage(result?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountsAsync = ref.watch(getAccountsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: accountsAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(
              color: Palette.petrolBlue,
              strokeWidth: 2,
            ),
          ),
          error: (err, _) => Center(
            child: Text(
              "Impossible de charger vos comptes.",
              style: FontsStyles.regular.copyWith(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          data: (response) {
            final accounts = response?.data;

            if (accounts == null) {
              return Center(
                child: Text(
                  response?.message ?? "Une erreur est survenue.",
                  style: FontsStyles.regular.copyWith(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              );
            }

            return _buildBody(accounts);
          },
        ),
      ),
    );
  }

  Widget _buildBody(TransferAccountsData accounts) {
    final fromLabel = _direction == null
        ? null
        : (_isFromPersonal
              ? accounts.personalAccount.name
              : accounts.merchantAccount?.name);
    final fromType = _direction == null
        ? null
        : (_isFromPersonal ? 'Personnel' : 'Marchand');
    final fromBalance = _direction == null
        ? null
        : (_isFromPersonal
              ? accounts.personalAccount.balance
              : accounts.merchantAccount?.balance);

    final toLabel = _direction == null
        ? null
        : (_isFromPersonal
              ? accounts.merchantAccount?.name
              : accounts.personalAccount.name);
    final toType = _direction == null
        ? null
        : (_isFromPersonal ? 'Marchand' : 'Personnel');
    final toBalance = _direction == null
        ? null
        : (_isFromPersonal
              ? accounts.merchantAccount?.balance
              : accounts.personalAccount.balance);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  size: 16,
                  color: Palette.black,
                ),
              ),
            ),

            const SizedBox(height: 22),

            Text(
              'Transfert',
              style: FontsStyles.bold.copyWith(
                fontSize: 20,
                color: Palette.black,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Entre votre compte personnel et votre compte marchand.',
              style: FontsStyles.regular.copyWith(
                fontSize: 12.5,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'DEPUIS',
              style: FontsStyles.bold.copyWith(
                fontSize: 10.5,
                color: Colors.grey.shade400,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _pickFromAccount(accounts),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFEFEFEF)),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              fromLabel ?? 'Choisir un compte',
                              overflow: TextOverflow.ellipsis,
                              style: FontsStyles.medium.copyWith(
                                fontSize: 14,
                                color: fromLabel == null
                                    ? Colors.grey.shade400
                                    : Palette.black,
                              ),
                            ),
                          ),
                          if (fromType != null) ...[
                            const SizedBox(width: 8),
                            _TypeBadge(label: fromType),
                          ],
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        if (fromBalance != null)
                          Text(
                            '${_formatAmount(fromBalance)} F',
                            style: FontsStyles.regular.copyWith(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.unfold_more_rounded,
                          size: 16,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'VERS',
              style: FontsStyles.bold.copyWith(
                fontSize: 10.5,
                color: Colors.grey.shade400,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAF8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            toLabel ?? 'Se remplit automatiquement',
                            overflow: TextOverflow.ellipsis,
                            style: FontsStyles.medium.copyWith(
                              fontSize: 14,
                              color: toLabel == null
                                  ? Colors.grey.shade400
                                  : Palette.black,
                            ),
                          ),
                        ),
                        if (toType != null) ...[
                          const SizedBox(width: 8),
                          _TypeBadge(label: toType),
                        ],
                      ],
                    ),
                  ),
                  if (toBalance != null)
                    Text(
                      '${_formatAmount(toBalance)} F',
                      style: FontsStyles.regular.copyWith(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'MONTANT',
              style: FontsStyles.bold.copyWith(
                fontSize: 10.5,
                color: Colors.grey.shade400,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Palette.petrolBlue),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      onChanged: (_) {
                        if (_errorMessage != null)
                          setState(() => _errorMessage = null);
                      },
                      style: FontsStyles.medium.copyWith(
                        fontSize: 22,
                        color: Palette.black,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: '0',
                        hintStyle: FontsStyles.medium.copyWith(
                          fontSize: 22,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'FCFA',
                    style: FontsStyles.regular.copyWith(
                      fontSize: 12,
                      color: const Color(0xFFB0AFA8),
                    ),
                  ),
                ],
              ),
            ),

            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: FontsStyles.regular.copyWith(
                  fontSize: 12.5,
                  color: const Color(0xFFA32D2D),
                ),
              ),
            ],

            const SizedBox(height: 24),
            DefaultButton(
              text: 'Transférer',
              onTap: (_loading || _direction == null)
                  ? null
                  : () => _handleSubmit(accounts),
              isEnable: _direction != null,
              padding: 16,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.label});

  final String label; // "Personnel" ou "Marchand"

  @override
  Widget build(BuildContext context) {
    final isMerchant = label == 'Marchand';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isMerchant ? const Color(0xFFFFF7E9) : const Color(0xFFF0FAF8),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: FontsStyles.medium.copyWith(
          fontSize: 10,
          color: isMerchant ? const Color(0xFF854F0B) : Palette.petrolBlue,
        ),
      ),
    );
  }
}

class _AccountOption extends StatelessWidget {
  const _AccountOption({
    required this.label,
    required this.typeLabel,
    required this.balance,
    required this.onTap,
  });

  final String label;
  final String typeLabel; // "Personnel" ou "Marchand"
  final double balance;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFEFEFEF)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: FontsStyles.medium.copyWith(
                        fontSize: 14,
                        color: Palette.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _TypeBadge(label: typeLabel),
                ],
              ),
            ),
            Text(
              '${balance.toInt()} F',
              style: FontsStyles.regular.copyWith(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
