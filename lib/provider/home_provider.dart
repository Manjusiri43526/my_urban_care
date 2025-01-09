import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int _activeCategoryIndex = 0;

  // Getter for selected index
  int get selectedIndex => _selectedIndex;

  // Getter for active category index
  int get activeCategoryIndex => _activeCategoryIndex;

  // Setter for selected index
  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  // Setter for active category index
  void setActiveCategoryIndex(int index) {
    if (_activeCategoryIndex != index) {
      _activeCategoryIndex = index;
      notifyListeners();
    }
  }
}
