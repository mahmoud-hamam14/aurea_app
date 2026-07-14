class CartItemModel {
  final String itemId;
  final String productId;
  final String productName;
  final String productCoverUrl;

  final int productStock;
  final double weightInGrams;

  final int quantity;
  final int discountPercentage;

  final double basePricePerUnit;
  final double finalPricePerUnit;
  final double totalPrice;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.productName,
    required this.productCoverUrl,
    required this.productStock,
    required this.weightInGrams,
    required this.quantity,
    required this.discountPercentage,
    required this.basePricePerUnit,
    required this.finalPricePerUnit,
    required this.totalPrice,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      itemId: json['itemId'] ?? '',

      productId: json['productId'] ?? '',

      productName: json['productName'] ?? '',

      productCoverUrl: json['productCoverUrl'] ?? '',

      productStock: json['productStock'] ?? 0,

      weightInGrams: (json['weightInGrams'] ?? 0).toDouble(),

      quantity: json['quantity'] ?? 0,

      discountPercentage: json['discountPercentage'] ?? 0,

      basePricePerUnit: (json['basePricePerUnit'] ?? 0).toDouble(),

      finalPricePerUnit: (json['finalPricePerUnit'] ?? 0).toDouble(),

      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
    );
  }
}
