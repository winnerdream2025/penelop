import 'package:corrispay/features/auth/dto/login_with_pin_dto.dart';
import 'package:corrispay/features/auth/providers/auth_provider.dart';
import 'package:corrispay/features/bases/providers/security_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';
import '../../../app/routes/routes_names.dart';
import '../../../core/local/userlocal_provider.dart';
import '../../../core/utils/functions.dart';
import '../../../l10n/app_localizations.dart';

class LoginWithPinCodeView extends ConsumerStatefulWidget {
  const LoginWithPinCodeView({super.key});

  @override
  ConsumerState<LoginWithPinCodeView> createState() =>
      _LoginWithPinCodeViewState();
}

class _LoginWithPinCodeViewState extends ConsumerState<LoginWithPinCodeView>
    with SingleTickerProviderStateMixin {
  String codePin = "";
  static const int pinLength = 6;
  bool _hasError = false;
  late List<String> shuffledNumbers;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _generateShuffledNumbers();
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

  void _generateShuffledNumbers() {
    final numbers = List.generate(10, (index) => index.toString());
    numbers.shuffle();
    shuffledNumbers = numbers;
  }

  void onNumberPressed(String value) {
    if (codePin.length < pinLength) {
      setState(() {
        _hasError = false;
        codePin += value;
      });
      if (codePin.length == pinLength) {
        submitForm(validWithFingerPrint: false);
      }
    }
  }

  void onDelete() {
    if (codePin.isNotEmpty) {
      setState(() {
        _hasError = false;
        codePin = codePin.substring(0, codePin.length - 1);
      });
    }
  }

  void _triggerError(String? message) {
    setState(() {
      _hasError = true;
      codePin = "";
    });
    _shakeController.forward(from: 0);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _generateShuffledNumbers());
    });
  }

  void submitForm({required bool validWithFingerPrint}) async {
    final _ = ref.watch(userLocalProvider);
    showLoading();
    final response = await ref.read(
      loginWithCodePinProvider(
        LoginWithPinDto(
          codePin: validWithFingerPrint ? "" : codePin,
          biometricAuth: validWithFingerPrint,
        ),
      ).future,
    );
    hideLoading();

    if (response != null && response.status && response.data != null) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesNames.main,
        (route) => false,
        arguments: response.data!.dashboardData,
      );
    } else {
      _triggerError(response?.message);
      showErrorMessage(response?.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final user = ref.watch(userLocalProvider);
    final isFingerPrintEnabled = ref.watch(fingerprintEnabledProvider);
    final numbersWithoutZero = shuffledNumbers.where((e) => e != "0").toList();
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

                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Palette.petrolBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user != null
                          ? "${user.firstName[0]}${user.lastName[0]}"
                                .toUpperCase()
                          : "?",
                      style: FontsStyles.bold.copyWith(
                        fontSize: 20,
                        color: Palette.petrolBlue,
                      ),
                    ),
                  ),
                ),

                const Gap(12),

                Text(
                  user != null ? tr.helloUser(user.firstName) : tr.enterPinCode,
                  style: FontsStyles.bold.copyWith(fontSize: 20),
                ),

                const Gap(4),

                Text(
                  tr.enterPinCode,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),

                Gap(screenHeight * 0.04),

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
                        height: 13,
                        width: 13,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _hasError
                              ? Colors.red
                              : index < codePin.length
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
                      ? Padding(
                          key: const ValueKey('error'),
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            tr.pinIncorrect,
                            style: FontsStyles.regular.copyWith(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                        )
                      : const SizedBox(key: ValueKey('no-error'), height: 8),
                ),

                Gap(screenHeight * 0.04),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 12,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.2,
                        ),
                    itemBuilder: (context, index) {
                      if (index == 9) {
                        return _buildFingerprintButton(isFingerPrintEnabled);
                      }
                      if (index == 10) return _buildNumberButton("0");
                      if (index == 11) return _buildDeleteButton();
                      return _buildNumberButton(numbersWithoutZero[index]);
                    },
                  ),
                ),

                Gap(screenHeight * 0.04),

                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RoutesNames.forgotPincode,
                      arguments: true,
                    );
                  },
                  child: Text(
                    tr.forgotPin,
                    style: FontsStyles.regular.copyWith(
                      fontSize: 13,
                      color: Palette.petrolBlue,
                      decoration: TextDecoration.underline,
                      decorationColor: Palette.petrolBlue,
                      decorationThickness: 1.2,
                    ),
                  ),
                ),

                const Gap(16),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 56),
                  child: Divider(color: Colors.grey.shade200, height: 1),
                ),

                const Gap(16),

                GestureDetector(
                  onTap: () async {
                    showLoading();
                    await ref.read(logoutProvider.future);
                    ref.read(userLocalProvider.notifier).clearUser();
                    ref.invalidate(userLocalProvider);
                    hideLoading();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesNames.auth,
                      (route) => false,
                    );
                  },
                  child: Text(
                    tr.logout,
                    style: FontsStyles.regular.copyWith(
                      fontSize: 13,
                      color: Colors.red,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.red,
                      decorationThickness: 1.2,
                    ),
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
            style: FontsStyles.bold.copyWith(fontSize: 20, color: Colors.white),
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

  Widget _buildFingerprintButton(bool isFingerEnabled) {
    if (!isFingerEnabled) return const SizedBox();
    return GestureDetector(
      onTap: () async {
        final authenticated = await ref
            .read(securityServiceProvider)
            .authenticate();
        if (authenticated && mounted) {
          submitForm(validWithFingerPrint: true);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: Center(
          child: Icon(Icons.fingerprint, size: 26, color: Palette.petrolBlue),
        ),
      ),
    );
  }
}
