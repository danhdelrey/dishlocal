import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NumberFormatter {
  static String formatMoney(int money){
    return money.toCurrencyString(
      trailingSymbol: 'đ',
      mantissaLength: 0,
      thousandSeparator: ThousandSeparator.Period,
      useSymbolPadding: true,
    );
  }
}