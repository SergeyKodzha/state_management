import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable{}

class OrderDoOrder extends OrderEvent{
  @override
  List<Object?> get props => [];
}

class OrderFetchOrders extends OrderEvent{
  @override
  List<Object?> get props => [];

}
