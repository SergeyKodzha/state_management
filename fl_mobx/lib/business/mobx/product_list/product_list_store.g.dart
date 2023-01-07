// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductListStore on _ProductListStore, Store {
  Computed<StoreTabState>? _$stateComputed;

  @override
  StoreTabState get state =>
      (_$stateComputed ??= Computed<StoreTabState>(() => super.state,
              name: '_ProductListStore.state'))
          .value;

  late final _$_dataFutureAtom =
      Atom(name: '_ProductListStore._dataFuture', context: context);

  @override
  ObservableFuture<List<Product>>? get _dataFuture {
    _$_dataFutureAtom.reportRead();
    return super._dataFuture;
  }

  @override
  set _dataFuture(ObservableFuture<List<Product>>? value) {
    _$_dataFutureAtom.reportWrite(value, super._dataFuture, () {
      super._dataFuture = value;
    });
  }

  late final _$productsAtom =
      Atom(name: '_ProductListStore.products', context: context);

  @override
  List<Product>? get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(List<Product>? value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$fetchProductsAsyncAction =
      AsyncAction('_ProductListStore.fetchProducts', context: context);

  @override
  Future<void> fetchProducts() {
    return _$fetchProductsAsyncAction.run(() => super.fetchProducts());
  }

  @override
  String toString() {
    return '''
products: ${products},
state: ${state}
    ''';
  }
}
