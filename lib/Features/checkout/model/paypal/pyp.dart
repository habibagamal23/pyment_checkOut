class PaymentTransaction {
  final Amount amount;
  final String description;
  final ItemList itemList;

  PaymentTransaction({
    required this.amount,
    required this.description,
    required this.itemList,
  });

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) {
    return PaymentTransaction(
      amount: Amount.fromJson(json['amount']),
      description: json['description'],
      itemList: ItemList.fromJson(json['item_list']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount.toJson(),
      'description': description,
      'item_list': itemList.toJson(),
    };
  }
}

class Amount {
  final String total;
  final String currency;
  final Details details;

  Amount({
    required this.total,
    required this.currency,
    required this.details,
  });

  factory Amount.fromJson(Map<String, dynamic> json) {
    return Amount(
      total: json['total'],
      currency: json['currency'],
      details: Details.fromJson(json['details']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'currency': currency,
      'details': details.toJson(),
    };
  }
}

class Details {
  final String subtotal;
  final String shipping;
  final int shippingDiscount;

  Details({
    required this.subtotal,
    required this.shipping,
    required this.shippingDiscount,
  });

  factory Details.fromJson(Map<String, dynamic> json) {
    return Details(
      subtotal: json['subtotal'],
      shipping: json['shipping'],
      shippingDiscount: json['shipping_discount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtotal': subtotal,
      'shipping': shipping,
      'shipping_discount': shippingDiscount,
    };
  }
}

class ItemList {
  final List<Item> items;

  ItemList({
    required this.items,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) {
    return ItemList(
      items: (json['items'] as List)
          .map((item) => Item.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class Item {
  final String name;
  final int quantity;
  final String price;
  final String currency;

  Item({
    required this.name,
    required this.quantity,
    required this.price,
    required this.currency,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'currency': currency,
    };
  }
}
