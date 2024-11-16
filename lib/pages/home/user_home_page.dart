import 'package:flutter/material.dart';
import 'package:gusto_condiviso/pages/courses/courses_feed_page.dart';
import 'package:gusto_condiviso/pages/profiles/user_profile_page.dart';
import 'package:gusto_condiviso/pages/promotional_codes/promotional_codes_page.dart';
import 'package:gusto_condiviso/pages/recipes/recipes_feed_page.dart';
import 'package:gusto_condiviso/pages/subscriptions/user_subscription_page.dart';
import 'package:gusto_condiviso/pages/video_classes/video_classes_feed_page.dart';

class UserHomePage extends StatelessWidget{
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {

    var selectedIndex = 0;

    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: NavigationRail(
              selectedIndex: 0,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  selectedIcon: Icon(
                    Icons.feed
                  ),
                  icon: Icon(
                    Icons.feed_outlined
                  ),
                  label: Text("Ricette")
                ),
                NavigationRailDestination(
                  selectedIcon: Icon(
                    Icons.featured_video
                  ),
                  icon: Icon(
                    Icons.featured_video_outlined
                  ),
                  label: Text("Lezioni")
                ),
                NavigationRailDestination(
                  selectedIcon: Icon(
                    Icons.class_
                  ),
                  icon: Icon(
                    Icons.class_outlined
                  ),
                  label: Text("Corsi")
                ),
                NavigationRailDestination(
                  selectedIcon: Icon(
                    Icons.card_giftcard
                  ),
                  icon: Icon(
                    Icons.card_giftcard_outlined
                  ),
                  label: Text("Promozioni")
                ),
                NavigationRailDestination(
                  selectedIcon: Icon(
                    Icons.subscriptions
                  ),
                  icon: Icon(
                    Icons.subscriptions_outlined
                  ),
                  label: Text("Abbonamento")
                ),
                NavigationRailDestination(
                  selectedIcon: Icon(
                    Icons.account_circle
                  ),
                  icon: Icon(
                    Icons.account_circle_outlined
                  ),
                  label: Text("Profilo")
                ),
              ]
            ),
          ),

          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),

          Expanded(
            child: switch (selectedIndex) {
              0 => const RecipesFeedPage(),
              1 => const VideoClassesFeedPage(),
              2 => const CoursesFeedPage(),
              3 => const PromotionalCodesPage(),
              4 => const UserSubscriptionPage(),
              5 => const UserProfilePage(),
              _ => const RecipesFeedPage()
            }
          )
        ],
      ),
    );
  }
}