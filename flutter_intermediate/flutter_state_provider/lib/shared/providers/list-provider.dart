// ignore_for_file: file_names

import 'package:flutter/material.dart';

class NumbersListProvider extends ChangeNotifier {
  List<int> numbers = [1, 2, 3, 4];

  void add() {
    int last = numbers.last;
    numbers.add(last + 1);
    notifyListeners();
  }
}
