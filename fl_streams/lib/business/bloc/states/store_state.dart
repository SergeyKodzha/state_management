import 'package:equatable/equatable.dart';

import '../../entities/product.dart';

enum StoreStatus { idle, loading, loaded }

class StoreState extends Equatable {
  final StoreStatus status;
  final List<Product> products;

  StoreState({required this.status, required this.products});
  StoreState.initial()
      : status = StoreStatus.idle,
        products = [];
  StoreState copyWith({StoreStatus? status, List<Product>? products}) =>
      StoreState(
          status: status ?? this.status, products: products ?? this.products);

  @override
  List<Object?> get props => [status, products];
}
