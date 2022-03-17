// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

enum ChocolateFlavorsEnum {
  White,
  Dark,
  Milk,
}

enum TableFieldsEnum {
  product_id,
  product_name,
  net_weight,
  quantity,
  price,
  flavor,
  last_date_release,
  last_date_receive,
}

class Utils {
  static String generateProductID(String seed) {
    var digest = sha1.convert(utf8.encode(seed));

    String _hash = digest.toString();

    return _hash.substring(0, 7) + _hash.substring(_hash.length - 8, _hash.length);
  }

  static String formatToPHPString(double price) {
    NumberFormat _toPHPString = NumberFormat("###.00#", "en_US");

    return '₱ ${_toPHPString.format(price)}';
  }

  static String formatToString(double price) {
    NumberFormat _toPHPString = NumberFormat("###.00#", "en_US");

    return _toPHPString.format(price);
  }

  static String dateTimeToString(DateTime _dateTime) {
    return '${DateFormat.EEEE().format(_dateTime)} ${DateFormat.yMMMd().format(_dateTime)} ${DateFormat.jm().format(_dateTime)}';
  }
}
