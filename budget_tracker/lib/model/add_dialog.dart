import 'package:budget_tracker/model/transaction_item.dart';
import 'package:flutter/material.dart';

/* This widget will have an Function(TransactionItem) itemToAdd that will
serve as a callback for when we press the Add Button */

class AddTransactionDialog extends StatefulWidget {
  final Function(TransactionItem) itemToAdd;
  const AddTransactionDialog({super.key, required this.itemToAdd});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.3,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: const [
              Text(
                "Add an expense",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
