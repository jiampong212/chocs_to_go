class Chocolates {
  final String productID;
  final String productName;
  final double netWeight;
  final int quantity;
  final double price;
  final String flavor;
  final DateTime expiryDate;
  final DateTime lastDateRelease;
  final DateTime lastDateReceive;
  Chocolates({
    required this.productID,
    required this.productName,
    required this.netWeight,
    required this.quantity,
    required this.price,
    required this.flavor,
    required this.expiryDate,
    required this.lastDateRelease,
    required this.lastDateReceive,
  });
}
