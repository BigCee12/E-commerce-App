import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shop/main.dart';
import 'package:shop/models/shop_models.dart';


void initiatePayment(BuildContext context, double amount,WidgetRef ref) async {
  Charge charge = Charge()
    ..amount = (amount * 100).toInt() // Paystack uses amounts in kobo
    ..email = 'reginaldejikeme852@mail.com'
    ..reference = DateTime.now().millisecondsSinceEpoch.toString();

  CheckoutResponse response = await plugin.checkout(
    context,
    method: CheckoutMethod.card, // You can use other methods as well
    charge: charge,
  );

  if (response.status == true) {
    ref.read(cartNotifierProvider.notifier).resetCart();
    print("Hello");
    // Payment was successful
    // You can handle success here, e.g., update order status, show a success message, etc.
  } else {
    print("No hello");
    // Payment failed
    // You can handle failure here, e.g., show an error message to the user
  }
}
