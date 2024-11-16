import 'package:flutter/material.dart';

class UserSubscriptionPage extends StatelessWidget {
  const UserSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.05,
        ),

        SizedBox(
          width: size.width,
          height: 30,
          child: const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Abbonamenti",
                  style: TextStyle(fontSize: 26),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: size.height * 0.1,
        ),

        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SubscriptionFree(),
            SubscriptionSilver(),
            SubscriptionGold()
          ],
        )
      ],
    );
  }
}


class SubscriptionFree extends StatelessWidget {
  const SubscriptionFree({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width * 0.25,
      height: size.height * 0.7,
      child: Card(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Free",
                    style: TextStyle(fontSize: 34),
                  )
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "0.0\$/mese",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Accesso alle ricette",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Seleziona",
                        style: TextStyle(fontSize: 25),
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubscriptionSilver extends StatelessWidget {
  const SubscriptionSilver({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width * 0.25,
      height: size.height * 0.7,
      child: Card(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Silver",
                    style: TextStyle(fontSize: 34),
                  )
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "5.90\$/mese",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Accesso alle ricette",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Accesso alle lezioni",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Seleziona",
                        style: TextStyle(fontSize: 25),
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubscriptionGold extends StatelessWidget {
  const SubscriptionGold({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width * 0.25,
      height: size.height * 0.7,
      child: Card(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Gold",
                    style: TextStyle(fontSize: 34),
                  )
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "10.90\$/mese",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Accesso alle ricette",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Accesso alle lezioni",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Accesso ai corsi",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Accesso alle promozioni",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Seleziona",
                        style: TextStyle(fontSize: 25),
                      )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
