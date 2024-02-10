import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final formatMoney =
    NumberFormat.currency(symbol: 'USD', locale: 'ar', decimalDigits: 2);
final formatNumber = NumberFormat('###,##0.00', 'en_US');
final formatDateDay = DateFormat.MMMMEEEEd('fr_FR');
final formatDateShort = DateFormat.yMMMEd('fr_FR');
final formatDayMonth = DateFormat.MMMd('fr_FR');
const versionApp = '1.0.1';
const cacheName = 'shem_services_caches';
final formatHour = DateFormat.Hm('fr_FR');

List<TextInputFormatter> formatDecimalNumber = [
  FilteringTextInputFormatter.allow(
    RegExp(r'^-?\d*\.?\d*$'),
  ),
  TextInputFormatter.withFunction((oldValue, newValue) {
    if (newValue.text.startsWith('.') || newValue.text.startsWith(' ')) {
      return oldValue.copyWith(text: '');
    }
    return newValue;
  }),
];

var formatPhoneNumber = MaskTextInputFormatter(
    mask: '+(243) ### ### ###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

String getPhoneNumber(String text) {
  final regex = RegExp(r'[()\[\]{ }<>\s\^\$\*\\?\|\\\.]');
  return text.replaceAll(regex, '');
}
