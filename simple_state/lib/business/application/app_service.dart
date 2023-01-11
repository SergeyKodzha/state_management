import 'package:simple_state/business/entities/mutable_cart.dart';

import '../entities/cart.dart';
import '../entities/cart_item.dart';
import '../entities/order.dart';
import '../entities/product.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../repositories/local_repository.dart';
import '../repositories/remote_repository.dart';

class AppService {
  final AuthRepository _authRepository;
  final LocalRepository _localRepository;
  final RemoteRepository _remoteRepository;

  AppService(
      this._authRepository, this._localRepository, this._remoteRepository);

  Future<User> login(String name, String pass) async {
    final user = await _authRepository.login(name, pass);
    await _remoteRepository.takeGuestCart(user.uid);
    return user;
  }

  Future<User> register(String name, String pass) async {
    final user = await _authRepository.register(name, pass);
    await _remoteRepository.takeGuestCart(user.uid);
    return user;
  }

  Future<Cart> fetchCart() async {
    final user = _authRepository.currentUser;
    Cart cart;
    if (user != null) {
      cart = await _remoteRepository.fetchCart(user.uid);
    } else {
      cart = await _localRepository.fetchCart();
    }
    return cart;
  }

  Future<Cart> setCartItem(CartItem item) async {
    print('set cart item');
    final cart = await fetchCart();
    final updated = cart.setItem(item);
    await _setCart(updated);
    return updated;
  }

  Future<Cart> removeCartItem(ProductID id) async {
    print('remove cart item');
    final cart = await fetchCart();
    final updated = cart.removeItemById(id);
    await _setCart(updated);
    return updated;
  }

  Future<List<Product>> fetchAllProducts() async {
    final user = _authRepository.currentUser;
    if (user != null) {
      return _remoteRepository.fetchAllProducts();
    } else {
      return _localRepository.fetchAllProducts();
    }
  }

  Future<Map<ProductID, Product>> fetchCartProducts(List<ProductID> ids) async {
    final user = _authRepository.currentUser;
    if (user != null) {
      return _remoteRepository.fetchCartProducts(ids);
    } else {
      return _localRepository.fetchCartProducts(ids);
    }
  }

  Future<Order?> order() async {
    final user = _authRepository.currentUser;
    if (user != null) {
      final order = await _remoteRepository.order(user.uid);
      return order;
    }
    return null;
  }

  Future<Order?> fetchOrder() async {
    final user = _authRepository.currentUser;
    if (user != null) {
      return await _remoteRepository.fetchOrder(user.uid);
    }
    return null;
  }

  Future<void> _setCart(Cart cart) async {
    final user = _authRepository.currentUser;
    if (user != null) {
      return _remoteRepository.setCart(user.uid, cart);
    } else {
      return _localRepository.setCart(cart);
    }
  }
}
