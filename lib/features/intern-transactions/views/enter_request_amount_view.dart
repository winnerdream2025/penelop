import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../bases/widgets/default_button.dart';

class EnterRequestAmountView extends ConsumerStatefulWidget {
  const EnterRequestAmountView({super.key});

  @override
  ConsumerState<EnterRequestAmountView> createState() =>
      _EnterRequestAmountViewState();
}

class _EnterRequestAmountViewState
    extends ConsumerState<EnterRequestAmountView> {
  final TextEditingController _controller = TextEditingController();
  String rawPrice = "0";

  @override
  void dispose() {

    _controller.dispose();
    super.dispose();
  }

  String formatNumber(String value) {
    if (value.isEmpty) return "0";
    final number = int.parse(value);
    final buffer = StringBuffer();
    final chars = number.toString().split('').reversed.toList();

    for (int i = 0; i < chars.length; i++) {
      if (i != 0 && i % 3 == 0) buffer.write(' ');
      buffer.write(chars[i]);
    }

    return buffer.toString().split('').reversed.join();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final user = ref.watch(userLocalProvider);

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Palette.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(12),

            Text(
              loc.which_amount,
              style: FontsStyles.bold.copyWith(fontSize: 24),
            ),

            const Gap(8),

            /// ✅ FIX ICI
            Text(
              loc.enter_requested_amount,
              style: FontsStyles.regular.copyWith(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),

            const Gap(40),

            /// ── Saisie du montant
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: IntrinsicWidth(
                      child: TextField(
                        cursorColor: Palette.petrolBlue,
                        controller: _controller,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          final cleaned = value
                              .replaceAll(' ', '')
                              .replaceFirst(RegExp(r'^0+'), '');

                          rawPrice = cleaned.isEmpty ? "0" : cleaned;

                          final formatted = formatNumber(rawPrice);

                          _controller.value = TextEditingValue(
                            text: formatted,
                            selection: TextSelection.collapsed(
                              offset: formatted.length,
                            ),
                          );

                          setState(() {});
                        },
                        style: FontsStyles.bold.copyWith(
                          color: Palette.black,
                          fontSize: 48,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0",
                          hintStyle: FontsStyles.bold.copyWith(
                            fontSize: 48,
                            color: Palette.black.withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(6),

                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    user?.targetCurrency ?? loc.currency,
                    style: FontsStyles.regular.copyWith(
                      color: Colors.grey.shade500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),



            const Spacer(),

            DefaultButton(
              isEnable: rawPrice != "0",
              text: loc.next,
              bgColor: Palette.petrolBlue,
              padding: 14,
              textStyle: FontsStyles.medium.copyWith(
                fontSize: 15,
                color: Palette.white,
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutesNames.receivePayment,
                  arguments: double.parse(rawPrice),
                );
              },
            ),

            const Gap(24),
          ],
        ),
      ),
    );
  }
}