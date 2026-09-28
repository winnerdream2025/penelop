import 'package:corrispay/app/routes/routes_names.dart';
import 'package:corrispay/features/auth/dto/create_update_pin.dto.dart';
import 'package:corrispay/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../app/design/fonts_styles.dart';
import '../../../../app/design/palette.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../core/utils/functions.dart';

enum _PinStep { create, confirm }

class CreateCodePinView extends ConsumerStatefulWidget {
  const CreateCodePinView({super.key});

  @override
  ConsumerState<CreateCodePinView> createState() => _CreateCodePinViewState();
}

class _CreateCodePinViewState extends ConsumerState<CreateCodePinView>
    with SingleTickerProviderStateMixin {
  _PinStep _step = _PinStep.create;
  String _firstPin = "";
  String _currentInput = "";
  bool _hasError = false;
  static const int pinLength = 6;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void onNumberPressed(String value) {
    if (_currentInput.length < pinLength) {
      setState(() {
        _hasError = false;
        _currentInput += value;
      });

      if (_currentInput.length == pinLength) {
        if (_step == _PinStep.create) {
          setState(() {
            _firstPin = _currentInput;
            _currentInput = "";
            _step = _PinStep.confirm;
          });
        } else {
          submitForm();
        }
      }
    }
  }

  void onDelete() {
    if (_currentInput.isNotEmpty) {
      setState(() {
        _hasError = false;
        _currentInput = _currentInput.substring(0, _currentInput.length - 1);
      });
    }
  }

  void _triggerError() {
    setState(() {
      _hasError = true;
      _currentInput = "";
    });
    _shakeController.forward(from: 0);
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _step = _PinStep.create;
          _firstPin = "";
          _hasError = false;
        });
      }
    });
  }

  void submitForm() async {
    if (_currentInput != _firstPin) {
      _triggerError();
      return;
    }

    showLoading();
    final response = await ref.read(
      createOrUpdatePinProvider(CreateUpdatePinDto(code: _currentInput)).future,
    );
    hideLoading();

    if (response != null && response.status && response.data != null) {
      showSuccessMessage(response.message);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesNames.main,
        (route) => false,
        arguments: response.data!.dashboardData,
      );
    } else {
      setState(() => _currentInput = "");
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final isConfirmStep = _step == _PinStep.confirm;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(screenHeight * 0.05),


                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    key: ValueKey(_step),
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Palette.petrolBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isConfirmStep
                          ? Icons.lock_rounded
                          : Icons.lock_outline_rounded,
                      color: Palette.petrolBlue,
                      size: 26,
                    ),
                  ),
                ),

                const Gap(16),


                Text(
                  tr.createPinCode,
                  style: FontsStyles.bold.copyWith(fontSize: 24),
                ),

                const Gap(4),


                Text(
                  tr.pinDescription,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),

                const Gap(20),


                Row(
                  children: List.generate(2, (index) {
                    final isActive = isConfirmStep ? true : index == 0;
                    return Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: index == 0 ? 6 : 0),
                        height: 4,
                        decoration: BoxDecoration(
                          color: isActive
                              ? Palette.petrolBlue
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    );
                  }),
                ),

                Gap(screenHeight * 0.03),


                Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      key: ValueKey(_step),
                      isConfirmStep
                          ? tr.confirmPin
                          : tr.pinUsageHint,
                      textAlign: TextAlign.center,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),

                Gap(screenHeight * 0.03),


                AnimatedBuilder(
                  animation: _shakeAnimation,
                  builder: (context, child) {
                    final offset = _hasError
                        ? 8.0 *
                        (0.5 - (_shakeAnimation.value % 1.0)).abs() *
                        2
                        : 0.0;
                    return Transform.translate(
                      offset: Offset(
                        offset * (_shakeAnimation.value < 0.5 ? 1 : -1),
                        0,
                      ),
                      child: child,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pinLength,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.all(7),
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _hasError
                              ? Colors.red
                              : index < _currentInput.length
                              ? Palette.petrolBlue
                              : Colors.transparent,
                          border: Border.all(
                            color: _hasError ? Colors.red : Palette.petrolBlue,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),


                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _hasError
                      ? Center(
                    child: Padding(
                      key: const ValueKey('error'),
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        tr.pinMismatch,
                        style: FontsStyles.regular.copyWith(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                      : const SizedBox(key: ValueKey('no-error'), height: 8),
                ),

                Gap(screenHeight * 0.04),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 12,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.2,
                    ),
                    itemBuilder: (context, index) {
                      if (index == 9) return const SizedBox();
                      if (index == 11) return _buildDeleteButton();
                      final number = index == 10 ? "0" : "${index + 1}";
                      return _buildNumberButton(number);
                    },
                  ),
                ),

                const Gap(32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return GestureDetector(
      onTap: () => onNumberPressed(number),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Palette.petrolBlue,
        ),
        child: Center(
          child: Text(
            number,
            style: FontsStyles.bold.copyWith(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return GestureDetector(
      onTap: onDelete,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: const Center(
          child: Icon(
            Icons.backspace_outlined,
            size: 18,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}