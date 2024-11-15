import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'Features/checkout/presentation/views/my_cart_view.dart';

void main() {
  Stripe.publishableKey = "pk_test_51QLO18KCYYcZnriZlyXhnG9ZCL51lgQVnNkTiSDje6oveaCmfxdUNmevP06mmqzdevZTi2GKJBTvsWRcM12u9jOY0043YgS4XM";

  runApp(const CheckoutApp());
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyCartView(),
    );
  }
}
