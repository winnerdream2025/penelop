import 'package:flutter/services.dart';


class PhoneNumberFormatter extends TextInputFormatter {
  final int characterCount;

  PhoneNumberFormatter(this.characterCount);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    if (newValue.text.isEmpty) {
      return newValue;
    }
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (newText.length > characterCount) {
      newText = newText.substring(0, characterCount);
    }
    StringBuffer formattedText = StringBuffer();
    int groupSize = characterCount == 8 ? 2 : 3;
    for (int i = 0; i < newText.length; i++) {
      if (i > 0 && i % groupSize == 0) {
        formattedText.write(' ');
      }
      formattedText.write(newText[i]);
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class SpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (newText.length > 3) {
      newText = '${newText.substring(0, 3)} ${newText.substring(3)}';
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}






class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LettersOnlyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final RegExp letterRegExp = RegExp(r'^[a-zA-ZÀ-ÿ\s]*$');
    if (letterRegExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}


class CapitalizeFirstCharFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if (newValue.text.isEmpty) {
      return newValue;
    }

    String capitalizedText = newValue.text[0].toUpperCase() + newValue.text.substring(1);

    return TextEditingValue(
      text: capitalizedText,
      selection: TextSelection.collapsed(offset: capitalizedText.length),
    );
  }
}





class EmailTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if (newValue.text.isNotEmpty && RegExp(r'^\d').hasMatch(newValue.text)) {
      return oldValue;
    }
    if (newValue.text.isNotEmpty && !isValidEmail(newValue.text)) {
      return newValue;
    }
    return newValue;
  }

  bool isValidEmail(String email) {

    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z][a-zA-Z0-9._%+-]*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }
}


class MultipleOf50Above100InputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;

    if (text.isEmpty) return newValue;

    final int? number = int.tryParse(text);

    if (number == null) {
      return oldValue;
    }

    if (number >= 100 && number % 50 == 0) {
      return newValue;
    }
    return oldValue;
  }
}



class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String sanitized = newValue.text.replaceAll(RegExp(r'\D'), '');
    StringBuffer formatted = StringBuffer();
    for (int i = 0; i < sanitized.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted.write(' ');
      }
      formatted.write(sanitized[i]);
    }
    return TextEditingValue(
      text: formatted.toString(),
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
