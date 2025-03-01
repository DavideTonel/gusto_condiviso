import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gusto_condiviso/bloc/subscription/subscription_bloc.dart';
import 'package:gusto_condiviso/bloc/user/user_bloc.dart';

class UserSubscriptionPage extends StatelessWidget {
  const UserSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<SubscriptionsBloc, SubscriptionsState>(
      listener: (context, state) {},
      builder: (context, state) {
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
            Flexible(
              fit: FlexFit.loose,
              child: ListView.builder(
                itemCount: state.subscriptionTypes.length,
                itemBuilder: (context, index) {
                  final subscriptionType = state.subscriptionTypes[index];
                  return BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SubscriptionWidget(
                        name: subscriptionType.name,
                        pricePerMonth: subscriptionType.price,
                        description: subscriptionType.description,
                        selected: context.read<UserBloc>().state.user?.subscription?.subscriptionType.id ==subscriptionType.id,
                        onEnrollSubscription: () {
                          context.read<UserBloc>().add(
                            SetSubscription(
                              subscriptionType: subscriptionType
                            )
                          );
                        },
                        onCancelSubscription: () {
                          context.read<UserBloc>().add(
                            CancelSubscription()
                          );
                        },
                      );
                    },
                  );
                }
              ),
            ),
          ],
        );
      },
    );
  }
}

class SubscriptionWidget extends StatelessWidget {
  final String name;
  final String pricePerMonth;
  final String description;
  final bool selected;
  final VoidCallback onEnrollSubscription;
  final VoidCallback onCancelSubscription;

  const SubscriptionWidget(
      {
        super.key,
        required this.name,
        required this.pricePerMonth,
        required this.description,
        required this.selected,
        required this.onEnrollSubscription,
        required this.onCancelSubscription
      }
    );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: size.width * 0.5,
      height: size.height * 0.5,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 34),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$pricePerMonth/mese",
                    style: const TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16),
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
                        onPressed: selected ? onCancelSubscription : onEnrollSubscription,
                        child: Text(
                          selected ? "Annulla iscrizione" : "Seleziona",
                          style: const TextStyle(fontSize: 25),
                        )),
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
