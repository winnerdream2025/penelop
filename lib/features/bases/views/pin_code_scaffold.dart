import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';

/// Contrôleur permettant à l'écran appelant de piloter le shake/reset
/// depuis l'extérieur, de façon explicite et impérative — pas besoin
/// que la valeur d'un message change pour redéclencher l'animation
/// (contrairement à une comparaison `oldValue != newValue`, qui rate
/// le cas où la même erreur survient deux fois de suite).
///
/// Utilisation :
/// ```dart
/// final _pinController = PinCodeScaffoldController();
///
/// // Déclenche le shake + vide le champ, avec ou sans message :
/// _pinController.shake(tr.pinIncorrect);
/// _pinController.shake(); // shake sans message affiché
///
/// // Vide juste le champ sans animation (ex: reset silencieux) :
/// _pinController.clear();
/// ```
class PinCodeScaffoldController {
  _PinCodeScaffoldState? _state;

  void _attach(_PinCodeScaffoldState state) => _state = state;
  void _detach() => _state = null;

  /// Déclenche l'animation de shake, vide le PIN, et affiche
  /// [message] si fourni (aucun message = juste le shake visuel).
  void shake([String? message]) {
    _state?._triggerError(message);
  }

  /// Vide le PIN saisi sans déclencher de shake ni de message.
  void clear() {
    _state?._clearSilently();
  }
}

/// Écran générique de saisie de code PIN — gère l'affichage (dots,
/// clavier mélangé, animation shake sur erreur, bouton biométrie),
/// mais ne fait AUCUN appel API. Toute la logique métier (vérifier le
/// PIN, créer un compte, débloquer une transaction...) reste dans
/// l'écran appelant, via [onPinComplete] et/ou [controller].
///
/// Deux façons de déclencher un shake :
/// 1. Retourner un message d'erreur depuis [onPinComplete] (cas standard
///    — l'utilisateur vient de taper un PIN faux).
/// 2. Appeler `controller.shake()` depuis n'importe où dans l'écran
///    appelant (ex: après un échec biométrique, qui ne passe pas par
///    la saisie manuelle du PIN).
///
/// ```dart
/// final _pinController = PinCodeScaffoldController();
///
/// PinCodeScaffold(
///   controller: _pinController,
///   title: 'Bonjour, Sarah',
///   subtitle: tr.enterPinCode,
///   onPinComplete: (pin) => _handlePin(pin), // shake auto si erreur retournée
///   onFingerprintTap: () async {
///     final ok = await biometricAuth();
///     if (!ok) _pinController.shake(tr.biometricFailed); // shake manuel
///   },
/// )
/// ```
class PinCodeScaffold extends StatefulWidget {
  const PinCodeScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPinComplete,
    this.controller,
    this.avatarInitials,
    this.leadingIcon,
    this.onClose,
    this.pinLength = 6,
    this.isFingerprintEnabled = false,
    this.onFingerprintTap,
    this.bottomActions = const [],
  });

  final String title;
  final String subtitle;

  /// Affiche un avatar rond avec ces initiales (ex: écran de login,
  /// où l'utilisateur est déjà identifié). Ignoré si [leadingIcon] est
  /// fourni.
  final String? avatarInitials;

  /// Alternative à [avatarInitials] — affiche une icône dans le même
  /// rond coloré (ex: cadenas pour un écran de confirmation générique,
  /// où il n'y a pas d'identité précise à représenter).
  final IconData? leadingIcon;

  /// Si fourni, affiche un bouton de fermeture en haut à droite —
  /// pour les écrans "modaux" que l'utilisateur peut quitter (ex: une
  /// confirmation de transaction). Absent sur un écran obligatoire
  /// comme le login.
  final VoidCallback? onClose;

  final int pinLength;

  /// Appelé dès que l'utilisateur a saisi [pinLength] chiffres.
  /// Renvoyer `null` = succès, ne fait rien de plus ici (à l'écran
  /// appelant de naviguer). Renvoyer une chaîne = déclenche le shake
  /// avec ce message, automatiquement.
  final Future<String?> Function(String pin) onPinComplete;

  /// Optionnel — donne à l'écran appelant un contrôle direct sur le
  /// shake, indépendamment de [onPinComplete] (voir doc de la classe).
  final PinCodeScaffoldController? controller;

  final bool isFingerprintEnabled;
  final VoidCallback? onFingerprintTap;

  final List<PinCodeScaffoldAction> bottomActions;

  @override
  State<PinCodeScaffold> createState() => _PinCodeScaffoldState();
}

class _PinCodeScaffoldState extends State<PinCodeScaffold>
    with SingleTickerProviderStateMixin {
  String _codePin = '';
  bool _hasError = false;
  String? _errorMessage;
  bool _isSubmitting = false;
  late List<String> _shuffledNumbers;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _generateShuffledNumbers();
    widget.controller?._attach(this);
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void didUpdateWidget(covariant PinCodeScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach();
      widget.controller?._attach(this);
    }
  }

  @override
  void dispose() {
    widget.controller?._detach();
    _shakeController.dispose();
    super.dispose();
  }

  void _generateShuffledNumbers() {
    final numbers = List.generate(10, (index) => index.toString());
    numbers.shuffle();
    _shuffledNumbers = numbers;
  }

  Future<void> _onNumberPressed(String value) async {
    if (_codePin.length >= widget.pinLength || _isSubmitting) return;

    setState(() {
      _hasError = false;
      _codePin += value;
    });

    if (_codePin.length == widget.pinLength) {
      await _submit();
    }
  }

  void _onDelete() {
    if (_codePin.isEmpty || _isSubmitting) return;
    setState(() {
      _hasError = false;
      _codePin = _codePin.substring(0, _codePin.length - 1);
    });
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    final error = await widget.onPinComplete(_codePin);
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (error != null) {
      _triggerError(error);
    }
  }

  /// Déclenche shake + reset — appelable en interne (PIN faux saisi)
  /// ou depuis l'extérieur via [PinCodeScaffoldController.shake].
  void _triggerError(String? message) {
    if (!mounted) return;
    setState(() {
      _hasError = true;
      _errorMessage = message;
      _codePin = '';
    });
    _shakeController.forward(from: 0);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(_generateShuffledNumbers);
    });
  }

  /// Vide le PIN sans animation ni message — utile pour un reset
  /// silencieux (ex: l'utilisateur navigue ailleurs et revient).
  void _clearSilently() {
    if (!mounted) return;
    setState(() {
      _hasError = false;
      _errorMessage = null;
      _codePin = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final numbersWithoutZero =
    _shuffledNumbers.where((e) => e != '0').toList();
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
                Gap(screenHeight * 0.03),

                if (widget.onClose != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: widget.onClose,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade100,
                        ),
                        child: const Icon(Icons.close, size: 18),
                      ),
                    ),
                  ),

                Gap(screenHeight * 0.02),

                if (widget.leadingIcon != null) ...[
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Palette.petrolBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.leadingIcon,
                      color: Palette.petrolBlue,
                      size: 24,
                    ),
                  ),
                  const Gap(12),
                ] else if (widget.avatarInitials != null) ...[
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Palette.petrolBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.avatarInitials!.toUpperCase(),
                        style: FontsStyles.bold.copyWith(
                          fontSize: 20,
                          color: Palette.petrolBlue,
                        ),
                      ),
                    ),
                  ),
                  const Gap(12),
                ],

                Text(
                  widget.title,
                  style: FontsStyles.bold.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),

                const Gap(4),

                Text(
                  widget.subtitle,
                  style: FontsStyles.regular.copyWith(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),

                Gap(screenHeight * 0.04),

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
                      widget.pinLength,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.all(7),
                        height: 13,
                        width: 13,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _hasError
                              ? Colors.red
                              : index < _codePin.length
                              ? Palette.petrolBlue
                              : Colors.transparent,
                          border: Border.all(
                            color:
                            _hasError ? Colors.red : Palette.petrolBlue,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _hasError && _errorMessage != null
                      ? Padding(
                    key: const ValueKey('error'),
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _errorMessage!,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
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
                      if (index == 9) return _buildFingerprintButton();
                      if (index == 10) return _buildNumberButton('0');
                      if (index == 11) return _buildDeleteButton();
                      return _buildNumberButton(numbersWithoutZero[index]);
                    },
                  ),
                ),

                Gap(screenHeight * 0.04),

                for (final action in widget.bottomActions) ...[
                  GestureDetector(
                    onTap: action.onTap,
                    child: Text(
                      action.label,
                      style: FontsStyles.regular.copyWith(
                        fontSize: 13,
                        color: action.color,
                        decoration: TextDecoration.underline,
                        decorationColor: action.color,
                        decorationThickness: 1.2,
                      ),
                    ),
                  ),
                  if (action != widget.bottomActions.last) ...[
                    const Gap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 56),
                      child: Divider(color: Colors.grey.shade200, height: 1),
                    ),
                    const Gap(16),
                  ],
                ],

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
      onTap: () => _onNumberPressed(number),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Palette.petrolBlue,
        ),
        child: Center(
          child: Text(
            number,
            style:
            FontsStyles.bold.copyWith(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return GestureDetector(
      onTap: _onDelete,
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

  Widget _buildFingerprintButton() {
    if (!widget.isFingerprintEnabled || widget.onFingerprintTap == null) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: widget.onFingerprintTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade200,
        ),
        child: const Center(
          child: Icon(
            Icons.fingerprint,
            size: 26,
            color: Palette.petrolBlue,
          ),
        ),
      ),
    );
  }
}

/// Un lien d'action en bas de l'écran (ex: "Mot de passe oublié",
/// "Se déconnecter"), avec sa propre couleur.
class PinCodeScaffoldAction {
  const PinCodeScaffoldAction({
    required this.label,
    required this.onTap,
    required this.color,
  });

  final String label;
  final VoidCallback onTap;
  final Color color;
}