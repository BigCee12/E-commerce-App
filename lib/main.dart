import 'package:flutter/material.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/intro_page.dart';
import 'package:shop/pages/shop_page.dart';
import 'package:shop/themes/light_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

final plugin = PaystackPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  plugin.initialize(publicKey: 'pk_test_ae394e50fe092ca9050a929eb6cf34987dae68a8');
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/intro_page": (context) => const IntroPage(),
        "/shop_page": (context) => const ShopPage(),
        "/cart_page": (context) => const CartPage(),
      },
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      theme: lightMode,
    );
  }
}
