import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: SizedBox(
          width: screenSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: CircularPercentIndicator(
                  // we set the radius to be half of the screen width every time
                  radius: screenSize.width / 2,
                  lineWidth: 10.0, // how thick the line is
                  percent: .5, // percent goes from 0 -> 1
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
                  /* To be able to use our Theme throughout the app,
                  we can access it using Theme.of(context).colorScheme
                  There are many fields inside the .colorScheme but here we
                  want the primary color, so we can just say .primary */
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
