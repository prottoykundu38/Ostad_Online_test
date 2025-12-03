class Product {
  final String id;
  final String productName;
  final int productCode;
  final String img;
  final int qty;
  final double unitPrice;
  final double totalPrice;

  Product({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.img,
    required this.qty,
    required this.unitPrice,
    required this.totalPrice,
  });

  // Factory method to convert JSON to Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productName: json['ProductName'],
      productCode: json['ProductCode'],
      img: json['Img'],
      qty: json['Qty'],
      unitPrice: json['UnitPrice'].toDouble(),
      totalPrice: json['TotalPrice'].toDouble(),
    );
  }
}
