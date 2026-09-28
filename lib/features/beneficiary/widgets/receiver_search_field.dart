import 'package:flutter/material.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';

/// Champ de recherche avec 3 états visuels :
/// - par défaut : bordure grise fine
/// - en focus/saisie : bordure bleu pétrole + halo, bouton pour effacer
/// - aucun résultat : bordure rouge (piloté par [hasNoResults], calculé
///   par le parent qui connaît le résultat du filtrage)
class ReceiverSearchField extends StatefulWidget {
  const ReceiverSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
    this.hasNoResults = false,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  final bool hasNoResults;

  @override
  State<ReceiverSearchField> createState() => _ReceiverSearchFieldState();
}

class _ReceiverSearchFieldState extends State<ReceiverSearchField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Color get _borderColor {
    if (widget.hasNoResults) return const Color(0xFFE24B4A);
    if (_isFocused) return Palette.petrolBlue;
    return const Color(0xFFEBEBEB);
  }

  Color get _iconColor {
    if (widget.hasNoResults) return const Color(0xFFE24B4A);
    if (_isFocused) return Palette.petrolBlue;
    return const Color(0xFFB0B0B0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _borderColor, width: 1.5),
            boxShadow: _isFocused
                ? [
              BoxShadow(
                color: Palette.petrolBlue.withOpacity(0.08),
                blurRadius: 0,
                spreadRadius: 3,
              ),
            ]
                : null,
          ),
          child: Row(
            children: [
              Icon(Icons.search_rounded, size: 17, color: _iconColor),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  onChanged: widget.onChanged,
                  style: FontsStyles.medium.copyWith(
                    fontSize: 13,
                    color: Palette.black,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: FontsStyles.regular.copyWith(
                      fontSize: 13,
                      color: const Color(0xFFB0B0B0),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              if (widget.controller.text.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    widget.controller.clear();
                    widget.onChanged('');
                  },
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFF0F0F0),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 12,
                      color: Color(0xFF8A8A8A),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}