import 'package:corrispay/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/dto/create_update_pin.dto.dart';
import '../../auth/providers/auth_provider.dart';

enum _PinStep { create, confirm }

class CreateRequiredCodePinView extends ConsumerStatefulWidget {
  const CreateRequiredCodePinView({super.key});

  @override
  ConsumerState<CreateRequiredCodePinView> createState() =>
      _CreateRequiredCodePinViewState();
}

class _CreateRequiredCodePinViewState
    extends ConsumerState<CreateRequiredCodePinView>
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
        }
        // En étape confirm, l'user valide manuellement via le bouton ✓
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

  void onValidate() {
    if (_currentInput.length != pinLength) return;
    submitForm();
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
      createRequiredPinProvider(CreateUpdatePinDto(code: _currentInput)).future,
    );
    hideLoading();

    if (response != null && response.status) {
      Navigator.pop(context);
      showSuccessMessage(response.message);
    } else {
      setState(() => _currentInput = "");
      showErrorMessage(response?.message);
    }
  }

  String _getTitle(AppLocalizations tr) {
    return _step == _PinStep.create
        ? tr.createPinCode
        : "Confirmer le code PIN";
  }

  String _getSubtitle() {
    return _step == _PinStep.create
        ? "Choisissez un code à 6 chiffres"
        : "Ressaisissez votre code pour confirmer";
  }

  IconData _getIcon() {
    return _step == _PinStep.create
        ? Icons.lock_outline_rounded
        : Icons.lock_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final isConfirmStep = _step == _PinStep.confirm;

    return Scaffold(
      backgroundColor: Palette.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            // AppBar manuelle — retour visible seulement étape 1
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  if (!isConfirmStep)
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    )
                  else
                    const SizedBox(width: 48),
                ],
              ),
            ),

            const Gap(8),

            // Stepper 2 étapes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
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
            ),

            const Gap(24),

            // Icône
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
                child: Icon(_getIcon(), color: Palette.petrolBlue, size: 26),
              ),
            ),

            const Gap(14),

            // Titre
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Text(
                key: ValueKey(_step),
                _getTitle(tr),
                style: FontsStyles.bold.copyWith(fontSize: 24),
              ),
            ),

            const Gap(6),

            // Sous-titre
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  key: ValueKey(_step),
                  _getSubtitle(),
                  textAlign: TextAlign.center,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),

            const Gap(24),

            // Dots avec shake
            AnimatedBuilder(
              animation: _shakeAnimation,
              builder: (context, child) {
                final offset = _hasError
                    ? 8.0 * (0.5 - (_shakeAnimation.value % 1.0)).abs() * 2
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

            // Message d'erreur inline
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _hasError
                  ? Padding(
                      key: const ValueKey('error'),
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Les codes PIN ne correspondent pas",
                        style: FontsStyles.regular.copyWith(
                          fontSize: 13,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : const SizedBox(key: ValueKey('no-error'), height: 10),
            ),

            const Spacer(),

            // Clavier
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 12,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  if (index == 9) {
                    return isConfirmStep
                        ? _buildValidateButton()
                        : const SizedBox();
                  }
                  if (index == 11) return _buildDeleteButton();
                  final number = index == 10 ? "0" : "${index + 1}";
                  return _buildNumberButton(number);
                },
              ),
            ),

            const Spacer(flex: 2),
          ],
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
            style: FontsStyles.bold.copyWith(fontSize: 22, color: Colors.white),
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
            size: 20,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildValidateButton() {
    final isComplete = _currentInput.length == pinLength;
    return GestureDetector(
      onTap: isComplete ? onValidate : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isComplete
              ? Palette.petrolBlue
              : Palette.petrolBlue.withOpacity(0.3),
        ),
        child: const Center(
          child: Icon(Icons.check, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}
