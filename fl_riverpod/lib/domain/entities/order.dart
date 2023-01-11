import 'package:flutter/cupertino.dart';

@immutable
class Order {
  final String id;
  final String ownerId;
  final int created;
  final int deliveryIn;
  final num cost;

  const Order(
      {required this.id,
      required this.ownerId,
      required this.created,
      required this.deliveryIn,
      required this.cost});

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        ownerId = json['ownerId'],
        created = json['created'],
        deliveryIn = json['deliveryIn'],
        cost = json['cost'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'ownerId': ownerId,
        'created': created,
        'deliveryIn': deliveryIn,
        'cost': cost
      };
}
