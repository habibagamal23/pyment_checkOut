import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import '../model/paypal/pyp.dart';
import '../presentation/views/my_cart_view.dart';
import '../presentation/views/thank_you_view.dart';

class ApiKeys {
  static const String clientID =
      "Ac2TbMRA6hDcwo5p6o3GzrC918f78sepjdYE0dUiA19BzuhY9mKZVFQwiYFbfDZIGJZMGYSB4SLfFx-J";
  static const String paypalSecretKey =
      "EF0mRWSDhCPAV4oKdGqYGcRqPSn51TP5A7kXsITvFqxJU8TZi9ajt1WjSb3C5DdchKScp78ZUVk836kR";
}

class OrderItemModel {
  String? name;
  int? quantity;
  String? price;
  String? currency;

  OrderItemModel({this.name, this.quantity, this.price, this.currency});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        name: json['name'] as String?,
        quantity: json['quantity'] as int?,
        price: json['price'] as String?,
        currency: json['currency'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'quantity': quantity,
        'price': price,
        'currency': currency,
      };
}

class Paypal {
  static var transctionsData = PaymentTransaction(
    amount: Amount(
        total: "100",
        currency: "USD",
        details: Details(shipping: "0", shippingDiscount: 0, subtotal: '100')),
    description: '',
    itemList: ItemList(items: [
      Item(
        currency: 'USD',
        name: 'Apple',
        price: "4",
        quantity: 10,
      ),
      Item(
        currency: 'USD',
        name: 'Apple',
        price: "5",
        quantity: 12,
      ),
    ]),
  );

  void exceutePaypalPayment(BuildContext context, PaymentTransaction payment) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.clientID,
        secretKey: ApiKeys.paypalSecretKey,
        transactions: [payment],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return const ThankYouView();
            }),
            (route) {
              if (route.settings.name == '/') {
                return true;
              } else {
                return false;
              }
            },
          );
        },
        onError: (error) {
          SnackBar snackBar = SnackBar(content: Text(error.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return const MyCartView();
            }),
            (route) {
              return false;
            },
          );
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }
}
