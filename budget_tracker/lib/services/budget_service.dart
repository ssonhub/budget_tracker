import 'package:flutter/material.dart';

import '../model/transaction_item.dart';

class BudgetService extends ChangeNotifier {
  /* We are currently only abstracting our budget in BudgetService but we
  should be actually keeping track of all the items and our balance there as well */

  /* Let's add an initial balance of 0.0. Balance is determined by expense - profits
  
  Let's also have our items List there with all the TransactionItems
  
  - Create a getter for _items
  - Create an addItem function that takes in a TransactionItem, adds it to the list,
  updates the balance, and call notifyListeners
  - To update the balance, you can abstract that in a separate function.
  If the item is an expense, you want to add that item.amount to the balance
  otherwise subtract */
  double _budget = 2000.0;
  double get budget => _budget;

  double balance = 0.0;

  List<TransactionItem> _items = [];
  List<TransactionItem> get items => _items;

  set budget(double value) {
    _budget = value;
    notifyListeners();
  }

  void addItem(TransactionItem item) {
    _items.add(item);
    updateBalance(item);
    notifyListeners();
  }

  void updateBalance(TransactionItem item) {
    if (item.isExpense) {
      balance += item.amount;
    } else {
      balance -= item.amount;
    }
  }
}
