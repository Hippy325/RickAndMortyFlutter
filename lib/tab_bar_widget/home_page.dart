import 'package:flutter/material.dart';
import 'package:flutter_application_1/tab_bar_widget/bottom_navigation.dart';
import 'package:flutter_application_1/tab_bar_widget/tab.dart';
import 'package:flutter_application_1/tab_bar_widget/tab_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final Map<TabItem, GlobalKey<NavigatorState>> _navigatorKeys = {
    TabItem.main: GlobalKey<NavigatorState>(),
    TabItem.favorite: GlobalKey<NavigatorState>(),
  };
  var _currentTab = TabItem.main;

  Map<TabItem, String> _additionalParams = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _selectTab(
    TabItem tabItem, {
    Map<TabItem, String> additionalParams = const {},
  }) {
    _additionalParams = additionalParams;
    if (tabItem == _currentTab) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            children: <Widget>[
              _buildOffstageNavigator(_currentTab),
            ],
          )
        ],
      ),
      bottomNavigationBar: MyBottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return TabNavigator(
      navigatorKey: _navigatorKeys[tabItem]!,
      tabItem: tabItem,
      additionalParams: _additionalParams,
    );
  }
}
