import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../business/entities/cart.dart';
import '../../business/entities/product.dart';
import '../interface/local_repository.dart';
import '../products_hardcode.dart';



class MockLocalRepository implements LocalRepository {
  Future<SharedPreferences> get _sPrefs async => await SharedPreferences.getInstance();
  MockLocalRepository(){
    //SharedPreferences.getInstance().then((sPrefs) => sPrefs.clear());
  }
  @override
  Future<Cart> fetchCart() async {
    //await Future.delayed(const Duration(seconds: 3));
    final Map<String,Cart> carts=await _getCartsFromSPrefs();
    return carts['guest']?? Cart([]);
  }

  @override
  Future<Map<ProductID,Product>> fetchCartProducts(List<ProductID>? ids) async {
    await Future.delayed(const Duration(seconds: 1));
    final Map<ProductID,Product> res={};
    for (final json in hardcode_products){
      if (ids==null || ids.contains(json['id'])) {
        //res.add(Product.fromJson(json));
        res[json['id']]=Product.fromJson(json);
      }
    }
    return res;
  }

  @override
  Future<List<Product>> fetchAllProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    final List<Product> res=[];
    for (final json in hardcode_products){
        res.add(Product.fromJson(json));
    }
    return res;
  }

  @override
  Future<void> setCart(Cart cart) async {
    //await Future.delayed(const Duration(seconds: 10));
    final Map<String,Cart> carts=await _getCartsFromSPrefs();
    carts['guest']=cart;
    _saveCartsToSPrefs(carts);
  }

  Future<Map<String,Cart>> _getCartsFromSPrefs() async {
    final sPrefs=await _sPrefs;
    final cartsStr=sPrefs.getStringList('cached_carts')??[];
    final Map<String,Cart> res={};
    for (final str in cartsStr){
      final entry=jsonDecode(str);
      final uid=entry['uid'];
      final cart=Cart.fromJson(entry['cart']);
      res[uid]=cart;
    }
    return res;
  }

  Future<void> _saveCartsToSPrefs(Map<String,Cart> carts) async {
    final sPrefs=await _sPrefs;
    final List<String> toSave=[];
    for (final uid in carts.keys){
      final entry={'uid':uid,'cart':carts[uid]};
      final str=jsonEncode(entry);
      print('cart entry: $str');
      toSave.add(str);
    }
    sPrefs.setStringList('cached_carts', toSave);
  }
}