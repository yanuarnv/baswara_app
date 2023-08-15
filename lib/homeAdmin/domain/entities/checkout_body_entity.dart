class CheckoutBodyEntity {
  List<Map<String, dynamic>> items;
  String totalPrice;

  CheckoutBodyEntity({
    required this.items,
    required this.totalPrice,
  });

}
