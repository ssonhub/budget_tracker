import 'package:budget_tracker/model/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransactionDialog extends StatefulWidget {
  final Function(TransactionItem) itemToAdd;

  const AddTransactionDialog({super.key, required this.itemToAdd});

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  /* we need to create that controller and we can do that in the body of
  our stateful widget. Let's call it itemTitleController and
  initialize it with TextEditingController() */
  final TextEditingController itemTitleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.3,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text(
                "Add an expense",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
              const TextField(
                // controller: itemTitleController,
                decoration: InputDecoration(hintText: "Name of expense"),
              ),
              TextField(
                // controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(hintText: "Amount in \$"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
