import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../business/entities/cart.dart';
import '../../business/entities/order.dart';
import '../../business/entities/product.dart';
import '../interface/remote_repository.dart';
import '../products_hardcode.dart';

class MockRemoteRepository implements RemoteRepository {
  Future<SharedPreferences> get _sPrefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<Cart> fetchCart(String uid) async {
    final Map<String, Cart> carts = await _getCartsFromSPrefs();
    final cart = carts[uid] ?? Cart([]);
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
    if (guestCart != null) {
      await setCart(uid, guestCart);
      carts = await _getCartsFromSPrefs();
      carts.removeWhere((key, _) => key == 'guest');
      await _saveCartsToSPrefs(carts);
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
      final orders = await _getOrdersFromSPrefs();
      final order = Order(
          id: orders.length.toString(),
          ownerId: uid,
          created: DateTime.now().millisecondsSinceEpoch,
          deliveryIn: 2 * 30 * 1000,
          cost: cost);
      orders.add(order);
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
  Future<List<Order>> fetchOrders(String uid) async {
    await Future.delayed(const Duration(seconds: 1));
    final orders = await _getOrdersFromSPrefs();
    final List<Order> res = [];
    for (final order in orders) {
      if (order.ownerId == uid) {
        res.add(order);
      }
    }
    return res;
  }

  Future<List<Order>> _getOrdersFromSPrefs() async {
    final sPrefs = await _sPrefs;
    final ordStr = sPrefs.getStringList('cached_orders') ?? [];
    final List<Order> res = []; //uid->order
    for (final str in ordStr) {
      final entry = jsonDecode(str);
      final order = Order.fromJson(entry['order']);
      res.add(order);
    }
    return res;
  }

  Future<void> _saveOrdersToSPrefs(List<Order> orders) async {
    final sPrefs = await _sPrefs;
    final List<String> toSave = [];
    for (final order in orders) {
      final entry = {'uid': order.ownerId, 'order': order};
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
