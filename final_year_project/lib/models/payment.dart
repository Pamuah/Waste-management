import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  String _selectedPaymentMethod = '';

  String get selectedPaymentMethod => _selectedPaymentMethod;

  void selectPaymentMethod(String paymentMethod) {
    _selectedPaymentMethod = paymentMethod;
    notifyListeners();
  }
}
