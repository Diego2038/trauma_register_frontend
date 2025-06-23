import 'package:flutter/material.dart';

class ExpandableTitleProvider extends ChangeNotifier {
  // List of expansion states for each widget (by default, all are false)
  List<bool> _expandedStates = [];

  int currentAmountExpandedStates() => _expandedStates.length;

  // This controls whether all widgets should expand or collapse.
  bool isAllExpanded = false;

  // Method to update the expansion state of a specific widget
  void toggleExpansion(int index) {
    _expandedStates[index] = !_expandedStates[index];
    notifyListeners();
  }

  // Method to expand or collapse all widgets at once
  void setAllExpanded(bool expanded) {
    isAllExpanded = expanded;
    _expandedStates = List.filled(_expandedStates.length, expanded);
    notifyListeners();
  }

  // Method to initialize the expansion state list
  void initializeExpansions(int count) {
    _expandedStates = List.filled(count, false);
    notifyListeners();
  }

  bool getExpansionState(int index) => _expandedStates[index];
}