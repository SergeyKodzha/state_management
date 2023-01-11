class CartItem {
  final int productId;
  final int quantity;

  const CartItem(this.productId, this.quantity);

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      CartItem(json['productId'], json['quantity']);

  Map<String, dynamic> toJson() =>
      {'productId': productId, 'quantity': quantity};
}
