import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';
import '../../bases/widgets/rounded_back_button.dart';

const _petrol = Palette.petrolBlue;
const _petrolLight = Color(0xFFE6F4F5);
const _petrolBorder = Color(0x1F00616B);

class SupportContactView extends StatelessWidget {
  const SupportContactView({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final bottomPad = MediaQuery.of(context).padding.bottom;

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

            ),
          ),
          title: Text(
            tr.support,
            style: FontsStyles.bold.copyWith(
              color: Colors.black,
              fontSize: 16,
              letterSpacing: -0.3,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, bottomPad + 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Hero ─────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4F5).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _petrolBorder,
                    width: 0.5,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _petrolLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _petrolBorder,
                          width: 0.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.headset_mic_outlined,
                        size: 24,
                        color: _petrol,
                      ),
                    ),
                    const Gap(12),
                    Text(
                      tr.support_hero_title,
                      style: FontsStyles.bold.copyWith(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(6),
                    Text(
                      tr.support_hero_desc,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        height: 1.55,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const Gap(24),

              // ── Section : Nous contacter ──────────────────────
              _SectionLabel(label: tr.support_contact_label),
              const Gap(8),
              _ContactCard(
                rows: [
                  _ContactRow(
                    icon: Icons.phone_outlined,
                    label: tr.support_phone_label,
                    value: '+228 92 60 41 79',
                    onTap: () => _launch('tel:+22892604179'),
                  ),
                  _ContactRow(
                    icon: Icons.mail_outline_rounded,
                    label: tr.support_email_label,
                    value: 'support@caurispay.net',
                    onTap: () => _launch('mailto:support@caurispay.net'),
                  ),
                  _ContactRow(
                    icon: Icons.chat_outlined,
                    label: 'WhatsApp',
                    value: '+228 92 60 41 79',
                    onTap: () => _launch('https://wa.me/22892604179'),
                    isLast: true,
                  ),
                ],
              ),

              const Gap(20),

              // ── Section : Adresse ─────────────────────────────
              _SectionLabel(label: tr.support_address_label),
              const Gap(8),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFEBEBEB),
                    width: 0.5,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: _petrolLight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _petrolBorder,
                          width: 0.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: _petrol,
                      ),
                    ),
                    const Gap(14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr.support_headquarters,
                          style: FontsStyles.regular.copyWith(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          'Lomé, Togo',
                          style: FontsStyles.bold.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          tr.support_region,
                          style: FontsStyles.regular.copyWith(
                            fontSize: 12,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Gap(24),

              // ── Bouton site web ───────────────────────────────
              GestureDetector(
                onTap: () => _launch('https://caurispay.net/contact'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: _petrol,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.language_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                      const Gap(8),
                      Text(
                        tr.support_website_btn,
                        style: FontsStyles.bold.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(8),
                      const Icon(
                        Icons.open_in_new_rounded,
                        size: 14,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Section label
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
// Contact card
// ─────────────────────────────────────────────

class _ContactCard extends StatelessWidget {
  const _ContactCard({required this.rows});
  final List<_ContactRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFEBEBEB),
          width: 0.5,
        ),
      ),
      child: Column(children: rows),
    );
  }
}

// ─────────────────────────────────────────────
// Contact row
// ─────────────────────────────────────────────

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: _petrolLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _petrolBorder,
                      width: 0.5,
                    ),
                  ),
                  child: Icon(icon, size: 18, color: _petrol),
                ),
                const Gap(14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        value,
                        style: FontsStyles.bold.copyWith(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            height: 0.5,
            thickness: 0.5,
            color: Colors.grey.shade100,
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}