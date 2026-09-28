import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../app/design/fonts_styles.dart';
import '../../../app/design/palette.dart';

class DefaultField extends StatelessWidget {
  const DefaultField(
      {super.key,
        required this.controller,
       this.label,
        this.inputsFormatters,
        this.type,
        this.changeObscur,
        this.isObscur,
        this.validator,
        this.maxLines,
        this.onChanged, this.prefixIconUrl, this.suffixIconUrl, required this.hintText});
  final TextEditingController controller;
  final String? label;
  final List<TextInputFormatter>? inputsFormatters;
  final TextInputType? type;
  final bool? isObscur;
  final VoidCallback? changeObscur;
  final Function(String?)? validator;
  final int? maxLines;
  final Function(String?)? onChanged;
  final String? prefixIconUrl;
  final String? suffixIconUrl;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         if(label!=null)...[
           Text(
             label!,
             style: FontsStyles.regular
                 .copyWith(color: Palette.black, fontSize: 12),
           ),
           Gap(4),

         ],
          SizedBox(
           height: 52,
            child: TextFormField(
              maxLines: maxLines ?? 1,
              obscureText: isObscur ?? false,
              inputFormatters: inputsFormatters,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Champ Obligatoire";
                }
                if (validator != null) {
                  return validator!(value);
                }
                return null;
              },
              controller: controller,
              onChanged: onChanged,
              keyboardType: type,
              cursorColor: Palette.petrolBlue,
              decoration: InputDecoration(
               /*
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(prefixIconUrl, colorFilter: ColorFilter.mode( Color(0xFF64748B), BlendMode.srcIn),),
                ),
                */
                hintText: hintText,
                  suffixIcon: isObscur != null && suffixIconUrl!=null
                      ? GestureDetector(
                    onTap: changeObscur,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: SvgPicture.asset(suffixIconUrl!, colorFilter: ColorFilter.mode( Color(0xFF64748B), BlendMode.srcIn),),
                    ),
                  )
                      : null,
                  hintStyle: FontsStyles.regular
                      .copyWith(fontSize: 12, color: const Color(0xFF64748B)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      const BorderSide(color: Color(0xFFE2E8F0), width: 1)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      const BorderSide(color: Color(0xFFE2E8F0), width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                      const BorderSide(color: Color(0xFFE2E8F0), width: 1))),
            ),
          ),
        ],
      ),
    );
  }
}