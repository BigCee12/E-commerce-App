// import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shop/models/product_model.dart';

class Shop {
  final List<Product> _shop = [
    Product(
      id: 1,
      name: "Iphone 13",
      price: 1500,
      description: "You'd wanna buy it",
      imagePath: 'assets/images/iphone_13.webp',
    ),
    Product(
      id: 2,
      name: "Nike Shoe",
      price: 700,
      description: "You'd wanna buy it",
      imagePath: 'assets/images/NIKE.png',
    ),
    Product(
      id: 3,
      name: "T-Shirt",
      price: 100,
      description: "You'd wanna buy it",
      imagePath: 'assets/images/polo.webp',
    ),
    Product(
      id: 4,
      name: "White Cap",
      price: 40.2,
      description: "You'd wanna buy it",
      imagePath: 'assets/images/white cap.png',
    ),
    Product(
      id: 5,
      name: "Bullock Footwear",
      price: 250,
      description: "You'd wanna buy it",
      imagePath: 'assets/images/shoes.png',
    ),
  ];

  // Cart
  final List<Product> _cart = [];

  List<Product> get shop {
    return _shop;
  }

  List<Product> get cart {
    return _cart;
  }

  void addToCart(Product item) {
    _cart.add(item);
  }

  void removeFromCart(Product item) {
    _cart.remove(item);
  }
}

// Create Shop Riverpod providers
final shopProvider = Provider((ref) => Shop());
final shopListProvider = Provider((ref) => ref.watch(shopProvider).shop);

// Create Shop Riverpod providers
class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier(List<Product> initialState) : super(initialState);

  void addToCart(Product item) {
    final existingItemIndex =
        state.indexWhere((product) => product.id == item.id);

    if (existingItemIndex != -1) {
      // If the item is already in the cart, increase its quantity
      final updatedCart = List<Product>.from(state);
      updatedCart[existingItemIndex] = updatedCart[existingItemIndex]
          .copyWith(quantity: updatedCart[existingItemIndex].quantity + 1);
      state = updatedCart;
    } else {
      // If the item is not in the cart, add it with a quantity of 1
      state = [...state, item.copyWith(quantity: 1)];
    }
  }

  void removeFromCart(Product item) {
    final existingItemIndex =
        state.indexWhere((product) => product.id == item.id);

    if (existingItemIndex != -1) {
      final updatedCart = List<Product>.from(state);
      final existingItem = updatedCart[existingItemIndex];

      if (existingItem.quantity > 1) {
        // Decrease the quantity
        updatedCart[existingItemIndex] =
            existingItem.copyWith(quantity: existingItem.quantity - 1);
        state = updatedCart;
      } else {
        // Remove the item from the cart if quantity is 1
        updatedCart.removeAt(existingItemIndex);
        state = updatedCart;
      }
    }
  }

  void resetCart() {
    state = [];
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;

    for (var item in state) {
      totalPrice += item.price * item.quantity;
    }

    return totalPrice;
  }
}

final cartNotifierProvider = StateNotifierProvider<CartNotifier, List<Product>>(
  (ref) => CartNotifier([]), // Initialize with an empty cart
);
