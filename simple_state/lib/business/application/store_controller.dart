import 'package:flutter/cupertino.dart';

import '../entities/product.dart';
import 'app_service.dart';

class StoreController extends ChangeNotifier{
  AppService _appService;
  //
  bool _isLoading=false;
  bool get isLoading=>_isLoading;
  //
  List<Product> _products=[];
  List<Product> get products=>List.unmodifiable(_products);

  StoreController(AppService service):_appService=service{
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    _isLoading=true;
    notifyListeners();
    _products=await _appService.fetchAllProducts();
    _isLoading=false;
    notifyListeners();
  }
}