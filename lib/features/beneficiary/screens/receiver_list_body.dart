import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';
import '../models/beneficiary.model.dart';
import '../widgets/receiver_screen_title.dart';
import '../widgets/receiver_search_field.dart';
import '../widgets/receiver_section_label.dart';
import '../widgets/receiver_tile.dart';

class ReceiverListBody extends StatefulWidget {
  const ReceiverListBody({
    super.key,
    required this.tr,
    required this.beneficiaries,
    required this.contacts,
    required this.searchController,
    required this.selectedReceiver,
    required this.onAddTap,
    required this.onSearchChanged,
  });

  final AppLocalizations tr;
  final List<Beneficiary> beneficiaries;
  final List<Beneficiary> contacts;
  final TextEditingController searchController;
  final Beneficiary? selectedReceiver;
  final VoidCallback onAddTap;
  final VoidCallback onSearchChanged;

  @override
  State<ReceiverListBody> createState() => _ReceiverListBodyState();
}

class _ReceiverListBodyState extends State<ReceiverListBody> {
  static const int _previewCount = 4;

  bool _beneficiariesExpanded = false;
  bool _contactsExpanded = false;

  List<Beneficiary> _filter(List<Beneficiary> source) {
    final q = widget.searchController.text.toLowerCase();
    if (q.isEmpty) return source;
    return source.where((b) {
      return b.firstName.toLowerCase().contains(q) ||
          b.lastName.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final tr = widget.tr;
    final filteredBeneficiaries = _filter(widget.beneficiaries);
    final filteredContacts = _filter(widget.contacts);

    final isSearching = widget.searchController.text.isNotEmpty;
    final hasNoResults = isSearching &&
        filteredBeneficiaries.isEmpty &&
        filteredContacts.isEmpty;

    final visibleBeneficiaries = (isSearching || _beneficiariesExpanded)
        ? filteredBeneficiaries
        : filteredBeneficiaries.take(_previewCount).toList();

    final visibleContacts = (isSearching || _contactsExpanded)
        ? filteredContacts
        : filteredContacts.take(_previewCount).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(8),
                ReceiverScreenTitle(tr: tr),
                const Gap(14),


                ReceiverSearchField(
                  controller: widget.searchController,
                  hintText: tr.searchReceiver,
                  hasNoResults: hasNoResults,
                  onChanged: (_) => widget.onSearchChanged(),
                ),

                if (hasNoResults) ...[
                 SizedBox(height: MediaQuery.of(context).size.width * 0.4),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Text(
                        'Aucun contact trouve pour "${widget.searchController.text}"',
                        style: FontsStyles.regular.copyWith(
                          fontSize: 11,
                          color: const Color(0xFFE24B4A),
                        ),
                      ),
                    ),
                  ),
                ],

                const Gap(14),

                // ── Nouveau contact ──────────────────────────────
                if (!isSearching)
                  GestureDetector(
                    onTap: widget.onAddTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFEBEBEB),
                          width: 1.5,
                        ),
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
                              Icons.person_add_alt_1_rounded,
                              color: Palette.white,
                              size: 16,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: Text(
                              tr.addNewReceiver,
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

                if (!isSearching) const Gap(22),

                // ── Section : Contacts enregistrés ──────────────
                if (filteredBeneficiaries.isNotEmpty) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReceiverSectionLabel(label: tr.savedReceivers),
                      Text(
                        '${filteredBeneficiaries.length}',
                        style: FontsStyles.bold.copyWith(
                          fontSize: 10,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  ...visibleBeneficiaries.map(
                        (b) => ReceiverTile(
                      receiver: b,
                      selectedReceiver: widget.selectedReceiver,
                    ),
                  ),
                  if (!isSearching &&
                      filteredBeneficiaries.length > _previewCount)
                    _ToggleMoreButton(
                      expanded: _beneficiariesExpanded,
                      color: Palette.petrolBlue,
                      collapsedLabel:
                      'Voir les ${filteredBeneficiaries.length} contacts',
                      expandedLabel: 'Réduire',
                      onTap: () => setState(
                            () => _beneficiariesExpanded = !_beneficiariesExpanded,
                      ),
                    ),
                  const Gap(20),
                ],

                // ── Section : Cauris Contacts ────────────────────
                if (filteredContacts.isNotEmpty) ...[
                  Row(
                    children: [
                      Icon(
                        Icons.people_alt_rounded,
                        size: 12,
                        color: Colors.grey.shade400,
                      ),
                      const Gap(6),
                      const ReceiverSectionLabel(label: 'Cauris Contacts'),
                      const Spacer(),
                      Text(
                        '${filteredContacts.length}',
                        style: FontsStyles.bold.copyWith(
                          fontSize: 10,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  ...visibleContacts.map(
                        (c) => ReceiverTile(
                      receiver: c,
                      selectedReceiver: widget.selectedReceiver,
                      isContact: true,
                    ),
                  ),
                  if (!isSearching && filteredContacts.length > _previewCount)
                    _ToggleMoreButton(
                      expanded: _contactsExpanded,
                      color: Palette.orange,
                      collapsedLabel:
                      'Voir les ${filteredContacts.length} contacts',
                      expandedLabel: 'Réduire',
                      onTap: () => setState(
                            () => _contactsExpanded = !_contactsExpanded,
                      ),
                    ),
                ],

                const Gap(32),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ToggleMoreButton extends StatelessWidget {
  const _ToggleMoreButton({
    required this.expanded,
    required this.color,
    required this.collapsedLabel,
    required this.expandedLabel,
    required this.onTap,
  });

  final bool expanded;
  final Color color;
  final String collapsedLabel;
  final String expandedLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                expanded ? expandedLabel : collapsedLabel,
                style: FontsStyles.bold.copyWith(fontSize: 12, color: color),
              ),
              const Gap(4),
              Icon(
                expanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}