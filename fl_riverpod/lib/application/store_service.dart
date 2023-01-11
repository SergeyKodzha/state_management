import 'package:fl_riverpod/application/repository/auth_repository.dart';
import 'package:fl_riverpod/application/repository/local_repository.dart';
import 'package:fl_riverpod/application/repository/remote_repository.dart';
import 'package:fl_riverpod/helper/mutable_cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/presentation/provider/repository_provider.dart';
import '../domain/entities/Cart.dart';
import '../domain/entities/cart_item.dart';
import '../domain/entities/order.dart';
import '../domain/entities/product.dart';
import '../domain/entities/user.dart';
import '../presentation/cart/provider/cart_provider.dart';

class StoreService {
  final ProviderRef ref;
  final AuthRepository _authRepository;
  final LocalRepository _localRepository;
  final RemoteRepository _remoteRepository;

  StoreService(this.ref)
      : _authRepository = ref.read(authRepoProvider),
        _localRepository = ref.read(localRepoProvider),
        _remoteRepository = ref.read(remoteRepoProvider);

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
    ref.read(cartProvider.notifier).updateState(cart);
    return cart;
  }

  Future<void> setCartItem(CartItem item) async {
    print('set cart item');
    final cart = await fetchCart();
    final updated = cart.setItem(item);
    await _setCart(updated);
    ref.read(cartProvider.notifier).updateState(updated);
  }

  Future<void> removeCartItem(ProductID id) async {
    print('remove cart item');
    final cart = await fetchCart();
    final updated = cart.removeItemById(id);
    await _setCart(updated);
    ref.read(cartProvider.notifier).updateState(updated);
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
      ref.invalidate(cartProvider);
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

  Future<void> logout() async {
    await _authRepository.logout();
  }
}
