import 'package:flutter/foundation.dart';

class DetailsModel with ChangeNotifier {
  String _bags = '';
  String _description = '';
  String _wasteCollector = '';
  String _address = '';

  String get bags => _bags;
  String get description => _description;
  String get wastCollector => _wasteCollector;
  String get address => _address;

  void setBags(String value) {
    _bags = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  void wastecollector(String collectorCompany) {
    _wasteCollector = collectorCompany;
    notifyListeners();
  }

  void setAddress(String value) {
    _address = value;
    notifyListeners();
  }
}
