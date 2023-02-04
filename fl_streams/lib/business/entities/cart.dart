import 'package:flutter/material.dart';

import 'cart_item.dart';

@immutable
class Cart {
  final List<CartItem> items;

  const Cart._internal(this.items);
  factory Cart(List<CartItem> items) =>
      Cart._internal(List.unmodifiable(items));
  factory Cart.fromJson(Map<String, dynamic> json) =>
      Cart((json['items'] as List)
          .map((json2) => CartItem.fromJson(json2 as Map<String, dynamic>))
          .toList());
  Map<String, dynamic> toJson() => {'items': items};
}
