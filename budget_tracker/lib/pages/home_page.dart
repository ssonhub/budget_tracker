import 'package:budget_tracker/model/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

/* For us to be able to display the cards when we click a button,
 we need some sort of state management that holds the List of cards 
 being displayed on the screen */

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* Let's create a list of transaction items to be displayed now.
  we'll add and remove from that List to be able to populate our transactions.
  The List will be of TransactionItem and will be empty to start */
  List<TransactionItem> items = [];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(
            () {
              items.add(
                TransactionItem(amount: 5.99, itemTitle: "Food"),
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
                  child: CircularPercentIndicator(
                    radius: screenSize.width / 2,
                    lineWidth: 10.0,
                    percent: .5,
                    backgroundColor: Colors.white,
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          "\$0",
                          style: TextStyle(
                              fontSize: 48, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Balance",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    progressColor: Theme.of(context).colorScheme.primary,
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

                /* you want the entire screen to be scrollable, not just the list
      (whwere you could achieve it with a ListView.builder()) 
      
      we'll call a generate method that is part of the List. This method takes
      in the size of the list as a parameter and provides a generator, which is
      just a callback with an int parameter representing the index that
      returns an index for each item */

                /* The only problem with this code is that it returns a List<Widget> and
      our column won't accept that. Thankfully we can use the spread operator (...) */

                ...List.generate(
                  items.length,
                  (index) => TransactionCard(
                    item: items[index],
                  ),
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
