class ProductRequest {
  String productId;
  String productName;
  String productDescription;
  double productPrice;
  int productQuantity;

  ProductRequest({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productQuantity,
  });

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productName": productName,
    "productDescription": productDescription,
    "productPrice": productPrice,
    "productQuantity": productQuantity,
  };
}

class ProductResponse {
  String message;
  String status;

  ProductResponse({
    required this.message,
    required this.status,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
    message: json["message"],
    status: json["status"],
  );
}
