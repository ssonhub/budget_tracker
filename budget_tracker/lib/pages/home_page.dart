import 'package:budget_tracker/model/add_dialog.dart';
import 'package:budget_tracker/model/transaction_item.dart';
import 'package:budget_tracker/services/budget_service.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TransactionItem> items = [];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddTransactionDialog(
                itemToAdd: (transactionItem) {
                  setState(() {
                    items.add(transactionItem);
                  });
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  /* when we insert a budget, it will rebuild the entire HomePage
                    widget. That's not very efficient as we only want couple of things that
                    are mostly inside CircularPercentIndicator 
                    
                    In order to optimize that for rebuilds, we can wrap the CircularPercentIndicator
                    in a Consumer<BudgetService> widget that will rebuild when the state changes,
                    but only what's inside of it*/

                  /* Consumer has a builder that provides a context, a value and a child.
                    The value is the one that requires more attention as it is the budget service
                    (the same value as if you did final budgetService = Provider.of<BudgetService>(context);)
                    
                    So if you want to access the budget variable inside BudgetService, all you do is
                    value.budget like we did earlier */
                  child: Consumer<BudgetService>(
                    builder: ((context, value, child) {
                      final budgetService = Provider.of<BudgetService>(context);

                      return CircularPercentIndicator(
                        radius: screenSize.width / 2,
                        lineWidth: 10.0,
                        percent: .5 / budgetService.budget,
                        backgroundColor: Colors.white,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "\$0",
                              style: TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Balance",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Budget: \$" + budgetService.budget.toString(),
                              style: const TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                        progressColor: Theme.of(context).colorScheme.primary,
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  "Items",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                // ...List.generate(
                //   items.length,
                //   (index) => TransactionCard(
                //     item: items[index],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final TransactionItem item;

  const TransactionCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 25),
              blurRadius: 50,
            )
          ],
        ),
        padding: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Text(
              item.itemTitle,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Text(
              (!item.isExpense ? "+ " : "- ") + item.amount.toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
