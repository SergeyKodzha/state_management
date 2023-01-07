import 'package:flutter/material.dart';

import '../entities/cart.dart';
import '../entities/cart_item.dart';
import '../entities/product.dart';
import 'app_service.dart';

class CartController extends ChangeNotifier{
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  //
  Cart? _cart;
  Cart? get cart=>_cart;
  //
  final AppService _appService;
  CartController(this._appService){
    fetchCart();
  }
  Future<void> fetchCart() async {
    _cart=null;
    _isLoading=true;
    notifyListeners();
    //await Future.delayed(Duration(seconds: 2));
    _cart=await _appService.fetchCart();
    _isLoading=false;
    notifyListeners();
  }
  Future<void> setCartItem(CartItem item) async {
    _isLoading=true;
    notifyListeners();
    //await Future.delayed(const Duration(seconds: 2));
    final updated=await _appService.setCartItem(item);
    _cart=updated;
    _isLoading=false;
    notifyListeners();
  }

  Future<void> removeCartItem(ProductID id) async {
    _isLoading=true;
    notifyListeners();
    _cart=await _appService.removeCartItem(id);
    _isLoading=false;
    notifyListeners();
  }
}