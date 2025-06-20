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

  static String formatCompactNumberStable(int number) {
    if (number < 1000) return number.toString();

    double value;
    String suffix;

    if (number < 1000000) {
      value = number / 1000;
      suffix = 'K';
    } else if (number < 1000000000) {
      value = number / 1000000;
      suffix = 'M';
    } else {
      value = number / 1000000000;
      suffix = 'B';
    }

    // Làm tròn xuống 1 chữ số thập phân
    double rounded = (value * 10).floorToDouble() / 10;

    return rounded.toStringAsFixed(rounded % 1 == 0 ? 0 : 1) + suffix;
  }

  static String formatCompactNumberStable2Decimals(int number) {
    if (number < 1000) return number.toString();

    double value;
    String suffix;

    if (number < 1000000) {
      value = number / 1000;
      suffix = 'K';
    } else if (number < 1000000000) {
      value = number / 1000000;
      suffix = 'M';
    } else {
      value = number / 1000000000;
      suffix = 'B';
    }

    // Làm tròn xuống 2 chữ số thập phân
    double rounded = (value * 100).floorToDouble() / 100;

    // Bỏ số 0 dư thừa: 2.00K -> 2K
    String text = rounded.toStringAsFixed(2);
    if (text.endsWith('.00')) {
      text = text.substring(0, text.length - 3);
    } else if (text.endsWith('0')) {
      text = text.substring(0, text.length - 1);
    }

    return text + suffix;
  }


}
