import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:shop/models/product_model.dart';
import 'package:shop/models/shop_models.dart';
import 'package:shop/payment/paystack.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  void removeItem(BuildContext context, Product product, WidgetRef ref) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text(
                "Reduce/Remove this item from  Cart?",
                softWrap: true,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              actions: [
                MaterialButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                MaterialButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                      ref
                          .watch(cartNotifierProvider.notifier)
                          .removeFromCart(product);
                    })
              ],
            ));
  }

  void payNow(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          "Anticipate!!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "C A R T ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? Center(
                    child: Text(
                      "Your Cart is Empty",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 3),
                        child: Card(
                          margin: const EdgeInsets.all(4),
                          color: Theme.of(context).colorScheme.primary,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Image.asset(
                                  item.imagePath,
                                  fit: BoxFit.contain,
                                  filterQuality: FilterQuality.high,
                                  height: 80,
                                  width: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    item.description,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Price: ${item.price.toString()}",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Qty: ${item.quantity.toString()}",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  removeItem(
                                    context,
                                    item,
                                    ref,
                                  );
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  child: const Icon(Icons.remove),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "SUBTOTAL",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "₦ ${ref.watch(cartNotifierProvider.notifier).calculateTotalPrice().toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                      ),
                    ),
                    child: Text(
                      "PAY NOW",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () async {
                      double totalAmount = ref
                          .watch(cartNotifierProvider.notifier)
                          .calculateTotalPrice();
                      initiatePayment(context, totalAmount, ref);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
