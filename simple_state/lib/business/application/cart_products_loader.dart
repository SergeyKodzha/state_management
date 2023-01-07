import 'package:flutter/cupertino.dart';

import '../entities/product.dart';
import 'app_service.dart';

class CartProductsLoader extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _hasData=false;
  bool get hasData=>_hasData;
  Map<ProductID, Product> _products = {};
  Map<ProductID, Product> get products => Map.unmodifiable(_products);
  final AppService _appService;
  CartProductsLoader(this._appService);
  Future<void> fetchProducts(List<ProductID> ids) async {
    _isLoading = true;
    _hasData=false;
    notifyListeners();
    _products = await _appService.fetchCartProducts(ids);
    _hasData=true;
    _isLoading = false;
    notifyListeners();
  }
  void consumeData(){
    _hasData=false;
    _products.clear();
  }
}
