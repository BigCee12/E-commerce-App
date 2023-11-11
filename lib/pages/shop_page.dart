import 'package:flutter/material.dart';
import 'package:shop/components/cart_count.dart';
import 'package:shop/components/custom_drawer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shop/components/my_product_tile.dart';
import 'package:shop/models/shop_models.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
class ShopPage extends ConsumerWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopList = ref.watch(shopListProvider);
    return Scaffold(
        appBar:  AppBar(
          actions: const [
             Padding(
              padding:  EdgeInsets.only(right: 14.0),
              child:  CartCount(),
            ),
          ],
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            "S H O P",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary),
          ),
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        drawer: const CustomDrawer(),
        body: ListView(
          children: [
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Text(
                "Choose from our Premium Products.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            SizedBox(
              height: 550,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: shopList.length,
                  itemBuilder: (context, index) {
                    final product = shopList[index];
                    return ProductsTile(
                      product: product,
                    );
                  }),
            ),
          ],
        ));
  }
}
