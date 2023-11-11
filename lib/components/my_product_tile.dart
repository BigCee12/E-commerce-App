import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/models/shop_models.dart';

class ProductsTile extends ConsumerWidget {
  const ProductsTile({
    super.key,
    required this.product,
  });
  final Product product;
  
  void addToCart(BuildContext context, Product product, WidgetRef ref) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text("Add this item to Cart?"),
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
                      ref.watch(cartNotifierProvider.notifier).addToCart(product);
                    })
              ],
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.primary,
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: Image.asset(product.imagePath,height: 100,),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                product.description,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  '₦${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      color: Theme.of(context).colorScheme.secondary),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      addToCart(
                        context,
                        product,
                        ref,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
