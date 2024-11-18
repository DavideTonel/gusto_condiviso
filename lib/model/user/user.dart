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
  final String startDate;
  final SubscriptionType subscriptionType;

  UserSubscription({required this.startDate, required this.subscriptionType}); 
}