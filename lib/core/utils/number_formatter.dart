import 'package:flutter_multi_formatter/formatters/formatter_extension_methods.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NumberFormatter {
  static String formatMoney(int money) {
    return money.toCurrencyString(
      trailingSymbol: 'đ',
      mantissaLength: 0,
      thousandSeparator: ThousandSeparator.Period,
      useSymbolPadding: true,
    );
  }

  static String formatDistance(double? distanceInMeters) {
    if (distanceInMeters == null) {
      return '?';
    }

    if (distanceInMeters < 1) {
      return '<1 m';
    } else if (distanceInMeters < 1000) {
      // Dưới 1km → hiển thị mét
      if (distanceInMeters < 10) {
        return '${distanceInMeters.toStringAsFixed(1)} m';
      } else if (distanceInMeters < 100) {
        return '${distanceInMeters.toStringAsFixed(0)} m';
      } else {
        return '${distanceInMeters.toStringAsFixed(0)} m';
      }
    } else if (distanceInMeters < 100000) {
      // Từ 1km đến dưới 100km
      final distanceInKm = distanceInMeters / 1000;
      if (distanceInKm < 10) {
        return '${distanceInKm.toStringAsFixed(1)} km';
      } else {
        return '${distanceInKm.toStringAsFixed(0)} km';
      }
    } else {
      return '>100 km';
    }
  }
}
