/* let's begin by refactoring our TransactionCard widget to take in
an TransactionItem instead that we will create.
This will abstract all those fields into a single object */

class TransactionItem {
  String itemTitle;
  double amount;
  bool isExpense;

  TransactionItem({
    required this.itemTitle,
    required this.amount,
    this.isExpense = true,
  });
}
