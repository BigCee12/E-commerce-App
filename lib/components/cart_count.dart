import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shop/models/shop_models.dart';

class CartCount extends ConsumerWidget {
  const CartCount({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartNotifierProvider);

    int itemCount = cart.fold<int>(0, (count, item) => count + item.quantity);

    return itemCount > 0
        ? Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/cart_page");
                },
                icon: Icon(
                  size: 26,
                  color: Theme.of(context).colorScheme.inversePrimary,
                   Icons.shopping_cart_rounded,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .colorScheme
                        .inversePrimary, // You can customize the color
                  ),
                  child: Text(
                    itemCount.toString(),
                    style:const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          )
        : IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/cart_page");
            },
            icon: Icon(
               Icons.shopping_cart_rounded,
              size: 26,
              color: Theme.of(context).colorScheme.inversePrimary,
             
            ),
          );
  }
}
