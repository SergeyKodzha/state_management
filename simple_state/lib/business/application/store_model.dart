import 'package:flutter/cupertino.dart';

import '../entities/product.dart';
import 'app_service.dart';

class StoreModel extends ChangeNotifier {
  AppService _appService;
  //
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  //
  List<Product> _products = [];
  List<Product> get products => List.unmodifiable(_products);

  StoreModel(AppService service) : _appService = service {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();
    _products = await _appService.fetchAllProducts();
    _isLoading = false;
    notifyListeners();
  }
}
