import 'package:budget_tracker/model/add_dialog.dart';
import 'package:budget_tracker/model/transaction_item.dart';
import 'package:budget_tracker/services/budget_service.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

/* The goal here is to make HomePage a stateless widget, so it is optimized */

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                  final budgetService =
                      Provider.of<BudgetService>(context, listen: false);
                  budgetService.addItem(transactionItem);
                  // setState() {} // NO need for that anymore
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
                  child: Consumer<BudgetService>(
                    builder: ((context, value, child) {
                      /* In the main Column, update our percent: with the
                        value.balance as the numerator 
                        
                        Here we are telling the graph to render a percentage
                        based on the balance that we hvae divided by our budget.
                        this will fill in the purple line on the indicator*/
                      return CircularPercentIndicator(
                        radius: screenSize.width / 3,
                        lineWidth: 10.0,
                        percent: value.balance / value.budget,
                        backgroundColor: Colors.white,
                        center: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /* Edit the text to  get rid of a trailing "."
                            that would appear if we covert from double to string
                            directly in our balance display 
                            
                            This method is used to get the value on the left side of the "."
                            So if it was displaying $540.5, now it just displays the $540 */
                            Text(
                              "\$" + value.balance.toString().split(".")[0],
                              style: const TextStyle(
                                  fontSize: 48, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Balance",
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "Budget: \$" + value.budget.toString(),
                              style: const TextStyle(fontSize: 10),
                            ),
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
                /* If we scroll a bit down, we can see that we were rendering our
                List of transaction using ...List.generate() -> I already commented it out tho
                This is fine if we have a few items and no state, but the preferred way is
                using a ListView.builder().
                We now will use a Consumer widget on top of it to provide the items from
                BudgetService and optimize it to only rebuild when the BudgetService changes */

                // ...List.generate(
                //   items.length,
                //   (index) => TransactionCard(
                //     item: items[index],
                //   ),
                // ),

                Consumer<BudgetService>(
                  builder: ((context, value, child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.items.length,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TransactionCard(
                            item: value.items[index],
                          );
                        });
                  }),
                ),
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
