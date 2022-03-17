import 'package:chocs_to_go/utilites.dart';

class Chocolates {
  final String productID;
  final String productName;
  final double netWeight;
  final int quantity;
  final double price;
  final String flavor;
  final DateTime? lastDateRelease;
  final DateTime? lastDateReceive;

  late String priceStringPHP;
  late String lastDateReleasedString;
  late String lastDateReceivedString;
  late String netWeightString;
  Chocolates({
    required this.productID,
    required this.productName,
    required this.netWeight,
    required this.quantity,
    required this.price,
    required this.flavor,
    required this.lastDateRelease,
    required this.lastDateReceive,
  }) {
    priceStringPHP = Utils.formatToPHPString(price);
    netWeightString = '$netWeight grams';

    if (lastDateReceive != null) {
      lastDateReceivedString = Utils.dateTimeToString(lastDateReceive!);
    } else {
      lastDateReceivedString = 'Not Specified';
    }

    if (lastDateRelease != null) {
      lastDateReleasedString = Utils.dateTimeToString(lastDateRelease!);
    } else {
      lastDateReleasedString = 'Not Specified';
    }
  }
  Chocolates.empty()
      : productID = '',
        quantity = 0,
        flavor = ChocolateFlavorsEnum.Dark.name,
        netWeight = 0,
        lastDateReceive = null,
        lastDateRelease = null,
        price = 0,
        productName = '' {
    priceStringPHP = Utils.formatToPHPString(price);
    netWeightString = '$netWeight grams';

    if (lastDateReceive != null) {
      lastDateReceivedString = Utils.dateTimeToString(lastDateReceive!);
    } else {
      lastDateReceivedString = 'Not Specified';
    }

    if (lastDateRelease != null) {
      lastDateReleasedString = Utils.dateTimeToString(lastDateRelease!);
    } else {
      lastDateReleasedString = 'Not Specified';
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Chocolates &&
        other.productID == productID &&
        other.productName == productName &&
        other.netWeight == netWeight &&
        other.quantity == quantity &&
        other.price == price &&
        other.flavor == flavor &&
        other.lastDateRelease == lastDateRelease &&
        other.lastDateReceive == lastDateReceive &&
        other.priceStringPHP == priceStringPHP &&
        other.lastDateReleasedString == lastDateReleasedString &&
        other.lastDateReceivedString == lastDateReceivedString;
  }

  @override
  int get hashCode {
    return productID.hashCode ^
        productName.hashCode ^
        netWeight.hashCode ^
        quantity.hashCode ^
        price.hashCode ^
        flavor.hashCode ^
        lastDateRelease.hashCode ^
        lastDateReceive.hashCode ^
        priceStringPHP.hashCode ^
        lastDateReleasedString.hashCode ^
        lastDateReceivedString.hashCode;
  }

  @override
  String toString() {
    return 'Chocolates(productID: $productID, productName: $productName, netWeight: $netWeight, quantity: $quantity, price: $price, flavor: $flavor, lastDateRelease: $lastDateRelease, lastDateReceive: $lastDateReceive, priceStringPHP: $priceStringPHP, lastDateReleasedString: $lastDateReleasedString, lastDateReceivedString: $lastDateReceivedString)';
  }
}
