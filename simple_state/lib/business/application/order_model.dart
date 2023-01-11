import 'package:flutter/cupertino.dart';

import '../entities/order.dart';
import 'app_service.dart';

class OrderModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Order? _order;
  Order? get order => _order;
  final AppService _appService;
  OrderModel(this._appService);
  Future<void> fetchOrder() async {
    _isLoading = true;
    notifyListeners();
    _order = await _appService.fetchOrder();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> doOrder() async {
    _isLoading = true;
    notifyListeners();
    _order = await _appService.order();
    _isLoading = false;
    notifyListeners();
  }
}
