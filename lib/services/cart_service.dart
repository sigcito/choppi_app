import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CartItem {
  final int productId;
  final String productName;
  final String productDescription;
  final String productPrice;
  final int storeId;
  final int quantity;

  CartItem({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.storeId,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productDescription': productDescription,
      'productPrice': productPrice,
      'storeId': storeId,
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      productDescription: json['productDescription'] as String,
      productPrice: json['productPrice'] as String,
      storeId: json['storeId'] as int,
      quantity: json['quantity'] as int? ?? 1,
    );
  }

  CartItem copyWith({int? quantity}) {
    return CartItem(
      productId: productId,
      productName: productName,
      productDescription: productDescription,
      productPrice: productPrice,
      storeId: storeId,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartService {
  static const String _cartKey = 'cart_items';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<CartItem>> getCartItems() async {
    try {
      final cartJson = await _storage.read(key: _cartKey);
      if (cartJson == null || cartJson.isEmpty) {
        return [];
      }
      final List<dynamic> jsonList = jsonDecode(cartJson);
      return jsonList
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> addToCart(CartItem item) async {
    final items = await getCartItems();

    final existingIndex = items.indexWhere(
      (i) => i.productId == item.productId && i.storeId == item.storeId,
    );

    if (existingIndex != -1) {
      items[existingIndex] = items[existingIndex].copyWith(
        quantity: items[existingIndex].quantity + 1,
      );
    } else {
      items.add(item);
    }

    await _saveCart(items);
  }

  Future<void> removeFromCart(int productId, int storeId) async {
    final items = await getCartItems();
    items.removeWhere(
      (item) => item.productId == productId && item.storeId == storeId,
    );
    await _saveCart(items);
  }

  Future<void> updateQuantity(int productId, int storeId, int quantity) async {
    final items = await getCartItems();
    final index = items.indexWhere(
      (item) => item.productId == productId && item.storeId == storeId,
    );

    if (index != -1) {
      if (quantity <= 0) {
        items.removeAt(index);
      } else {
        items[index] = items[index].copyWith(quantity: quantity);
      }
      await _saveCart(items);
    }
  }

  Future<void> clearCart() async {
    await _storage.delete(key: _cartKey);
  }

  Future<int> getCartItemCount() async {
    final items = await getCartItems();
    int total = 0;
    for (final item in items) {
      total += item.quantity;
    }
    return total;
  }

  Future<void> _saveCart(List<CartItem> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await _storage.write(key: _cartKey, value: jsonEncode(jsonList));
  }
}
