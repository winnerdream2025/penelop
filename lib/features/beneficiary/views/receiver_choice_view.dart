import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/bases/widgets/rounded_close_button.dart';
import 'package:corrispay/features/beneficiary/models/beneficiary.model.dart';
import 'package:corrispay/features/beneficiary/screens/receiver_empty_body.dart';
import 'package:corrispay/features/beneficiary/screens/receiver_error_body.dart';
import 'package:flutter/material.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/beneficiary.provider.dart';
import '../screens/receiver_list_body.dart';

class ReceiverChoiceView extends ConsumerStatefulWidget {
  const ReceiverChoiceView({super.key, required this.selectedReceiver});
  final Beneficiary? selectedReceiver;

  @override
  ConsumerState<ReceiverChoiceView> createState() => _ReceiverChoiceViewState();
}

class _ReceiverChoiceViewState extends ConsumerState<ReceiverChoiceView> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final suggestionsAsyncValue = ref.watch(receiverSuggestionsProvider);

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 0,
        leading: RoundedCloseButton(),
      ),
      body: suggestionsAsyncValue.when(
        data: (response) {
          if (response == null) {
            return ReceiverErrorBody(
              message: tr.common_error,
              btnText: tr.retry,
              onRetry: () => ref.invalidate(receiverSuggestionsProvider),
            );
          }

          if (response.status == false || response.data == null) {
            return ReceiverErrorBody(
              message: response.message,
              btnText: tr.retry,
              onRetry: () => ref.invalidate(receiverSuggestionsProvider),
            );
          }

          final beneficiaries = response.data!.beneficiaries;
          final contacts = response.data!.contacts;

          if (beneficiaries.isEmpty && contacts.isEmpty) {
            return Center(
              child: ReceiverEmptyBody(
                message: response.message,
                tr: tr,
                onAddTap: () =>
                    Navigator.pushNamed(context, RoutesNames.addNewReceiver),
              ),
            );
          }

          return ReceiverListBody(
            tr: tr,
            beneficiaries: beneficiaries,
            contacts: contacts,
            searchController: searchController,
            selectedReceiver: widget.selectedReceiver,
            onAddTap: () =>
                Navigator.pushNamed(context, RoutesNames.addNewReceiver),
            onSearchChanged: () => setState(() {}),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: Palette.petrolBlue),
        ),
        error: (_, __) => ReceiverErrorBody(
          message: tr.common_error,
          btnText: tr.retry,
          onRetry: () => ref.invalidate(receiverSuggestionsProvider),
        ),
      ),
    );
  }
}
