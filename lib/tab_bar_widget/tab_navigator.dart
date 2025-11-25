import 'package:flutter/material.dart';
import 'package:flutter_application_1/character_list/page/character_list_page.dart';
import 'package:flutter_application_1/favorite/page/favorite_page.dart';
import 'tab.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator({
    super.key,
    required this.navigatorKey,
    required this.tabItem,
    required this.additionalParams,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;
  final Map<TabItem, String> additionalParams;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        Widget currentPage;
        switch (tabItem) {
          case TabItem.main:
            currentPage = const CharacterListPage();
            break;
          case TabItem.favorite:
            currentPage = const FavoritePage();
            break;
        }
        return MaterialPageRoute(builder: (context) => currentPage);
      },
    );
  }
}
