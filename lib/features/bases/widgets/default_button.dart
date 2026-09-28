import 'package:corrispay/app/design/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/design/fonts_styles.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.text,
    this.icon,
    this.onTap,
    this.raduis,
    this.bgColor,
    this.iconColor,
    this.padding,
    this.brColor,
    this.isEnable = true,
    this.hPadding,
    this.textColor,
    this.textStyle,
    this.suffixIcon,
    this.isLoading = false,
    this.loadingColor,
    this.suffixIconSize
  });

  final String? text;
  final String? icon;
  final Color? loadingColor;
  final VoidCallback? onTap;
  final double? raduis;
  final Color? bgColor;
  final Color? brColor;
  final Color? iconColor;
  final Color? textColor;
  final double? padding;
  final bool isEnable;
  final double? hPadding;
  final TextStyle? textStyle;
  final String? suffixIcon;
  final bool isLoading;
  final double? suffixIconSize;

  @override
  Widget build(BuildContext context) {
    final buttonPadding = padding != null
        ? EdgeInsets.all(padding!)
        : EdgeInsets.symmetric(
      horizontal: 16,
      vertical: hPadding ?? 8,
    );

    final buttonColor = bgColor ?? Palette.petrolBlue.withOpacity(isEnable ? 1 : 0.2);

    final borderRadius = raduis != null
        ? BorderRadius.circular(raduis!)
        : BorderRadius.circular(100);

    final border = brColor != null
        ? Border.all(color: brColor!, width: 1)
        : null;

    return GestureDetector(
      onTap: isEnable && !isLoading ? onTap : null,
      child: Container(
        width: isLoading ? double.infinity : null,
        padding: buttonPadding,
        decoration: BoxDecoration(
          border: border,
          color:isEnable? buttonColor:Colors.grey.shade500,
          borderRadius: borderRadius,
          // shape: raduis != null ? BoxShape.rectangle : BoxShape.circle,
        ),
        child: isLoading
            ? SizedBox()
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (suffixIcon != null) ...[
              SvgPicture.asset(
                suffixIcon!,
                colorFilter: iconColor!=null?ColorFilter.mode(
                    iconColor!,  BlendMode.srcIn):null,
                width: suffixIconSize??24,
              ),
            ],
            if(suffixIcon!=null && text!=null)...[
              SizedBox(width: 12,)
            ],
            if (text != null) ...[
              Text(
                text!,
                style: textStyle ??
                    FontsStyles.regular.copyWith(
                        color: textColor ?? iconColor ?? Palette.white),
              ),

            ],
            if(text!=null && icon!=null)...[
              SizedBox(width: 8,)
            ],
            if (icon != null) ...[
              SvgPicture.asset(
                icon!,
                colorFilter: ColorFilter.mode(
                    iconColor ?? Palette.white, BlendMode.srcIn),
                width: 24,
              ),
            ],
          ],
        ),
      ),
    );
  }
}