import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../application/repository/remote_repository.dart';
import '../../common/data/products_hardcode.dart';
import '../../domain/entities/Cart.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/product.dart';

class MockRemoteRepository implements RemoteRepository {
  Future<SharedPreferences> get _sPrefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<Cart> fetchCart(String uid) async {
    //await Future.delayed(const Duration(seconds: 5));
    final Map<String, Cart> carts = await _getCartsFromSPrefs();

    print('remote carts:$carts');
    final cart=carts[uid] ?? Cart([]);
    return cart;
  }

  @override
  Future<List<Product>> fetchAllProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    final List<Product> res = [];
    for (final json in hardcode_products) {
      res.add(Product.fromJson(json));
    }
    return res;
  }

  @override
  Future<Map<ProductID, Product>> fetchCartProducts(
      List<ProductID>? ids) async {
    await Future.delayed(const Duration(seconds: 1));
    final Map<ProductID, Product> res = {};
    for (final json in hardcode_products) {
      if (ids == null || ids.contains(json['id'])) {
        //res.add(Product.fromJson(json));
        res[json['id']] = Product.fromJson(json);
      }
    }
    return res;
  }

  @override
  Future<void> setCart(String uid, Cart cart) async {
    final Map<String, Cart> carts = await _getCartsFromSPrefs();
    carts[uid] = cart;
    await _saveCartsToSPrefs(carts);
  }

  @override
  Future<bool> takeGuestCart(String uid) async {
    Map<String, Cart> carts = await _getCartsFromSPrefs();
    final guestCart = carts['guest'];
    //print('sync carts guestCart: $guestCart, userCart:$userCart');
    //if (guestCart!=null && guestCart.items.isNotEmpty && (userCart==null || userCart.items.isEmpty)) {
    if (guestCart != null) {
      await setCart(uid, guestCart);
      carts = await _getCartsFromSPrefs();
      carts.removeWhere((key, _) => key=='guest');
      await _saveCartsToSPrefs(carts);
      print('guest cart removed');
      return true;
    }
    return false;
  }

  @override
  Future<Order?> order(String uid) async {
    final products = await fetchAllProducts();
    final carts = await _getCartsFromSPrefs();
    final cart = carts[uid];
    if (cart != null) {
      num cost = 0;
      for (final item in cart.items) {
        final product = products.firstWhere((i) => i.id == item.productId);
        cost += item.quantity * product.price;
      }
      final order = Order(
          id: 'mock_order_id',
          ownerId: uid,
          created: DateTime.now().millisecondsSinceEpoch,
          deliveryIn: 1 * 10 * 1000,
          cost: cost);
      final orders = await _getOrdersFromSPrefs();
      orders[uid] = order;
      await _saveOrdersToSPrefs(orders);
      //wipe cart
      final carts = await _getCartsFromSPrefs();
      carts.removeWhere((key, _) => key == uid);
      await _saveCartsToSPrefs(carts);
      return order;
    }
    return null;
  }

  @override
  Future<Order?> fetchOrder(String uid) async {
    await Future.delayed(const Duration(seconds: 1));
    final orders = await _getOrdersFromSPrefs();
    final order = orders[uid];
    if (order != null) {
      if (DateTime.now().millisecondsSinceEpoch >=
          order.created + order.deliveryIn) {
        orders.remove(order);
        await _saveOrdersToSPrefs(orders);
        return null;
      }
    }
    return order;
  }

  Future<Map<String, Order>> _getOrdersFromSPrefs() async {
    final sPrefs = await _sPrefs;
    final ordStr = sPrefs.getStringList('cached_orders') ?? [];
    final Map<String, Order> res = {}; //uid->order
    for (final str in ordStr) {
      final entry = jsonDecode(str);
      final uid = entry['uid'];
      final order = Order.fromJson(entry['order']);
      res[uid] = order;
    }
    return res;
  }

  Future<void> _saveOrdersToSPrefs(Map<String, Order> orders) async {
    final sPrefs = await _sPrefs;
    final List<String> toSave = [];
    for (final uid in orders.keys) {
      final entry = {'uid': uid, 'order': orders[uid]};
      toSave.add(jsonEncode(entry));
    }
    sPrefs.setStringList('cached_orders', toSave);
  }

  Future<Map<String, Cart>> _getCartsFromSPrefs() async {
    final sPrefs = await _sPrefs;
    final cartsStr = sPrefs.getStringList('cached_carts') ?? [];
    final Map<String, Cart> res = {}; //uid->cart
    for (final str in cartsStr) {
      final entry = jsonDecode(str);
      final uid = entry['uid'];
      final cart = Cart.fromJson(entry['cart']);
      res[uid] = cart;
    }
    return res;
  }

  Future<void> _saveCartsToSPrefs(Map<String, Cart> carts) async {
    final sPrefs = await _sPrefs;
    final List<String> toSave = [];
    for (final uid in carts.keys) {
      final entry = {'uid': uid, 'cart': carts[uid]};
      toSave.add(jsonEncode(entry));
    }
    sPrefs.setStringList('cached_carts', toSave);
  }
}
