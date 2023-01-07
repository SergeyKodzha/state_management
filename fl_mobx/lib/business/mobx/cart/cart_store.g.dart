// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CartStore on _CartStore, Store {
  late final _$cartDataAtom =
      Atom(name: '_CartStore.cartData', context: context);

  @override
  CartData? get cartData {
    _$cartDataAtom.reportRead();
    return super.cartData;
  }

  @override
  set cartData(CartData? value) {
    _$cartDataAtom.reportWrite(value, super.cartData, () {
      super.cartData = value;
    });
  }

  late final _$stateAtom = Atom(name: '_CartStore.state', context: context);

  @override
  CartState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CartState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$fetchCartAsyncAction =
      AsyncAction('_CartStore.fetchCart', context: context);

  @override
  Future<void> fetchCart() {
    return _$fetchCartAsyncAction.run(() => super.fetchCart());
  }

  late final _$updateCartItemAsyncAction =
      AsyncAction('_CartStore.updateCartItem', context: context);

  @override
  Future<void> updateCartItem(CartItem item) {
    return _$updateCartItemAsyncAction.run(() => super.updateCartItem(item));
  }

  late final _$removeCartItemAsyncAction =
      AsyncAction('_CartStore.removeCartItem', context: context);

  @override
  Future<void> removeCartItem(int id) {
    return _$removeCartItemAsyncAction.run(() => super.removeCartItem(id));
  }

  @override
  String toString() {
    return '''
cartData: ${cartData},
state: ${state}
    ''';
  }
}
