import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../app/design/assets/assets_icons.dart';
import '../../../../app/design/fonts_styles.dart';

class StringValueChoiceScreen extends StatelessWidget {
  const StringValueChoiceScreen({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.choices,
  });
  final String? selectedValue;
  final List<String> choices;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      height: 1000,
      decoration: BoxDecoration(color: Palette.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 48),
          Gap(24),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: SvgPicture.asset(AssetsIcons.close),
            ),
          ),
          Gap(24),
          Expanded(
            child: ListView(
              children: choices.map((choice) {
                return GestureDetector(
                  onTap: () {
                    onChanged(choice);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          choice,
                          style: FontsStyles.bold.copyWith(
                            color: Palette.black,
                            fontSize: 20,
                          ),
                        ),
                        if (selectedValue == choice) ...[
                          SvgPicture.asset(AssetsIcons.check),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
