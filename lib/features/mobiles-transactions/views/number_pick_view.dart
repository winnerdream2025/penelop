import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../beneficiary/providers/devices_contacts_provider.dart';
import '../models/model_recipient.dart';

class NumberPickerView extends ConsumerStatefulWidget {
  const NumberPickerView({
    super.key,
    required this.dialCode,
    required this.countryLabel,
    required this.phoneLength,
    this.countryCode,
  });

  /// Indicatif du pays choisi précédemment (ex: "+229") — seuls les
  /// contacts dont le numéro commence par cet indicatif sont listés.
  final String dialCode;

  /// Nom du pays, pour le message explicatif ("... pour le Bénin").
  final String countryLabel;

  /// Nombre de chiffres attendu pour un numéro local valide dans ce
  /// pays — utilisé pour le compteur et la validation de la saisie
  /// manuelle.
  final int phoneLength;

  /// Code ISO du pays (ex: "TG"), optionnel — juste pour l'emoji
  /// drapeau dans le bottom sheet de saisie manuelle.
  final String? countryCode;

  @override
  ConsumerState<NumberPickerView> createState() => _NumberPickerViewState();
}

class _NumberPickerViewState extends ConsumerState<NumberPickerView> {
  final TextEditingController _searchController = TextEditingController();

  /// Indicatif normalisé sans "+", pour matcher le format stocké par
  /// DeviceContactsRepository (numéros toujours sans "+").
  String get _normalizedDialCode => widget.dialCode.replaceAll('+', '');

  void _openManualEntry() async {
    final entered = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ManualNumberSheet(
        dialCode: widget.dialCode,
        countryLabel: widget.countryLabel,
        phoneLength: widget.phoneLength,
        countryCode: widget.countryCode,
      ),
    );
    if (entered != null && entered.isNotEmpty && mounted) {
      Navigator.pop(
        context,
        MobileMoneyRecipient(phoneNumber: entered),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactsRepo = ref.watch(deviceContactsRepositoryProvider);

    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close_rounded, size: 15),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Numero de reception',
                style: FontsStyles.bold.copyWith(fontSize: 21),
              ),
              const SizedBox(height: 12),

              // ── Message explicatif ──────────────────────
              Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1E6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      size: 15,
                      color: Palette.orange,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Seuls les contacts enregistres au format international '
                            '(${widget.dialCode}...) et correspondant au ${widget.countryLabel} '
                            'sont affiches ici.',
                        style: FontsStyles.regular.copyWith(
                          fontSize: 11,
                          color: const Color(0xFF854F0B),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ── Recherche ──────────────────────────────
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      size: 17,
                      color: Color(0xFFBBBBBB),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        style: FontsStyles.regular.copyWith(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'Rechercher parmi ces contacts',
                          hintStyle: FontsStyles.regular.copyWith(
                            fontSize: 13,
                            color: const Color(0xFFBBBBBB),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ── Saisir un nouveau numéro ────────────────
              GestureDetector(
                onTap: _openManualEntry,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Palette.petrolBlue, width: 1.5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Palette.petrolBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.keyboard_alt_outlined,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Saisir un nouveau numero',
                          style: FontsStyles.bold.copyWith(
                            fontSize: 12.5,
                            color: Palette.black,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: Color(0xFFBBBBBB),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Text(
                'CONTACTS AU ${widget.countryLabel.toUpperCase()}',
                style: FontsStyles.bold.copyWith(
                  fontSize: 10.5,
                  color: const Color(0xFF9CA3AF),
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: FutureBuilder(
                  future: contactsRepo.getContactEntries(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Palette.petrolBlue,
                        ),
                      );
                    }

                    final allEntries = snapshot.data ?? [];

                    final countryEntries = allEntries
                        .where((e) => e.phoneNumber
                        .replaceAll('+', '')
                        .startsWith(_normalizedDialCode))
                        .toList();

                    final query = _searchController.text.toLowerCase();
                    final filtered = query.isEmpty
                        ? countryEntries
                        : countryEntries
                        .where((e) =>
                    e.name.toLowerCase().contains(query) ||
                        e.phoneNumber.contains(query))
                        .toList();

                    if (filtered.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            query.isEmpty
                                ? 'Aucun contact enregistre au format '
                                '${widget.dialCode} n\'a ete trouve.'
                                : 'Aucun contact trouve pour "$query"',
                            textAlign: TextAlign.center,
                            style: FontsStyles.regular.copyWith(
                              fontSize: 12.5,
                              color: const Color(0xFF9CA3AF),
                              height: 1.5,
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final entry = filtered[index];
                        return _ContactRow(
                          name: entry.name,
                          phoneNumber: entry.phoneNumber,
                          onTap: () => Navigator.pop(
                            context,
                            MobileMoneyRecipient(
                              name: entry.name,
                              phoneNumber: entry.phoneNumber,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.name,
    required this.phoneNumber,
    required this.onTap,
  });

  final String name;
  final String phoneNumber;
  final VoidCallback onTap;

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) return '#';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFEDEDED),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  _initials,
                  style: FontsStyles.bold.copyWith(
                    fontSize: 14,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: FontsStyles.bold.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    phoneNumber,
                    style: FontsStyles.regular.copyWith(
                      fontSize: 11.5,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bottom sheet de saisie manuelle du numéro — remplace l'ancien
/// AlertDialog générique. Renvoie le numéro complet (indicatif + local,
/// sans "+") via `Navigator.pop(context, number)`.
class _ManualNumberSheet extends StatefulWidget {
  const _ManualNumberSheet({
    required this.dialCode,
    required this.countryLabel,
    required this.phoneLength,
    this.countryCode,
  });

  final String dialCode;
  final String countryLabel;
  final int phoneLength;
  final String? countryCode;

  @override
  State<_ManualNumberSheet> createState() => _ManualNumberSheetState();
}

class _ManualNumberSheetState extends State<_ManualNumberSheet> {
  final TextEditingController _controller = TextEditingController();

  bool get _isComplete => _controller.text.length == widget.phoneLength;

  String get _flagEmoji {
    final code = widget.countryCode;
    if (code == null || code.length != 2) return '🌍';
    final base = 0x1F1E6;
    final chars = code.toUpperCase().codeUnits;
    return String.fromCharCodes(
      [base + (chars[0] - 65), base + (chars[1] - 65)],
    );
  }

  void _submit() {
    if (!_isComplete) return;
    Navigator.pop(
      context,
      '${widget.dialCode.replaceAll('+', '')}${_controller.text.trim()}',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        18,
        20,
        MediaQuery.of(context).viewInsets.bottom +
            MediaQuery.of(context).padding.bottom +
            24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFEBEBEB),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 18),

          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Palette.petrolBlue.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.keyboard_alt_outlined,
              size: 21,
              color: Palette.petrolBlue,
            ),
          ),
          const SizedBox(height: 14),

          Text(
            'Saisir un numero',
            style: FontsStyles.bold.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            'Le numero doit etre valide pour le ${widget.countryLabel}',
            style: FontsStyles.regular.copyWith(
              fontSize: 12,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_flagEmoji, style: const TextStyle(fontSize: 15)),
                    const SizedBox(width: 6),
                    Text(
                      widget.dialCode,
                      style: FontsStyles.bold.copyWith(
                        fontSize: 13.5,
                        color: Palette.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Palette.petrolBlue,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _controller,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(widget.phoneLength),
                      ],
                      onChanged: (_) => setState(() {}),
                      style: FontsStyles.medium.copyWith(
                        fontSize: 13.5,
                        color: Palette.black,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        hintText: 'Ex: 90123456',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_controller.text.length} / ${widget.phoneLength} chiffres',
              style: FontsStyles.regular.copyWith(
                fontSize: 11,
                color: _isComplete
                    ? const Color(0xFF0F6E56)
                    : const Color(0xFFDFB049),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: _isComplete ? _submit : null,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: _isComplete
                    ? Palette.petrolBlue
                    : const Color(0xFFEDEDED),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                'Valider ce numero',
                textAlign: TextAlign.center,
                style: FontsStyles.bold.copyWith(
                  fontSize: 14,
                  color: _isComplete
                      ? Colors.white
                      : const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Center(
              child: Text(
                'Annuler',
                style: FontsStyles.bold.copyWith(
                  fontSize: 13,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}