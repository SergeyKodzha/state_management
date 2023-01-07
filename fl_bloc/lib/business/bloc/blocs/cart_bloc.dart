import 'dart:async';

import 'package:fl_bloc/business/bloc/events/cart_events.dart';
import 'package:fl_bloc/business/bloc/states/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/app_service.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  final AppService _service;
  CartBloc(this._service):super(CartState.initial()){
    on<CartFetchData>(_fetchData);
    on<CartUpdateItem>(_updateItem);
    on<CartRemoveItem>(_removeItem);
  }

  Future<void> _fetchData(CartFetchData event, Emitter<CartState> emit) async {
    emit(state.copyWith(status:CartStatus.loading));
    final cart=await _service.fetchCart();
    final ids=cart.items.map((item) => item.productId).toList();
    final products=await _service.fetchCartProducts(ids);
    emit(state.copyWith(status:CartStatus.idle,cart: cart,products: products));
  }

  Future<void> _updateItem(CartUpdateItem event, Emitter<CartState> emit) async {
    emit(state.copyWith(status:CartStatus.busy));
    final updated=await _service.setCartItem(event.item);
    final products=state.products;
    if (!products.containsKey(event.item.productId)){
      final product=await _service.fetchCartProducts([event.item.productId]);
      products[event.item.productId]=product.values.first;
    }
    emit(state.copyWith(status:CartStatus.idle,cart: updated,products: products));
  }

  Future<void> _removeItem(CartRemoveItem event, Emitter<CartState> emit) async {
    emit(state.copyWith(status:CartStatus.busy));
    final updated=await _service.removeCartItem(event.productId);
    final products=state.products;
    products.removeWhere((key, value) => key==event.productId);
    emit(state.copyWith(status:CartStatus.idle,cart: updated,products: products));
  }
}