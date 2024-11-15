class PaymentIntentInputModel {
  final String amount;
  final String currency;

  PaymentIntentInputModel(
      {required this.amount, required this.currency});

  toJson() {
    return {
      'amount': '${amount}00',
      'currency': currency,
    };
  }
}


class PaymentIntentRequest {
  final int amount;
  final String currency;

  PaymentIntentRequest({
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}
