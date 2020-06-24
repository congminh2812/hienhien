import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';

class Format {
  static String formatMoney(double money) {
    final FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: money,
        settings: MoneyFormatterSettings(
            symbol: 'IDR',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 0,
            compactFormatType: CompactFormatType.short));

    return fmf.output.nonSymbol;
  }

  static String formatDate(DateTime dateTime) {
    final f = new DateFormat('yyyy-MM-dd');
    return f.format(dateTime);
  }
}
