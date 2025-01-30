import 'package:gusto_condiviso/model/user/subscription_type.dart';

class User {
  final String username;
  final String password;
  final String name;
  final String surname;
  final String mail;
  final String birthday; // YYYY-MM-DD

  UserSubscription? subscription;

  User(
    {
      required this.username,
      required this.password,
      required this.name,
      required this.surname,
      required this.mail,
      required this.birthday,
      this.subscription
    }
  );
}

class UserSubscription {
  final int id;
  final String startDate;
  final String? endDate;
  final SubscriptionType subscriptionType;

  UserSubscription(
    {
      required this.id,
      required this.startDate,
      this.endDate,
      required this.subscriptionType
    }
  ); 
}