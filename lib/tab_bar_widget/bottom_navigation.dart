import 'package:flutter/material.dart';
import 'tab.dart';

class MyBottomNavigation extends StatelessWidget {
  MyBottomNavigation({
    super.key,
    required this.currentTab,
    required this.onSelectTab,
  });

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  final Map<TabItem, String> tabs = {
    TabItem.main: 'Главная',
    TabItem.favorite: 'Избранные',
  };

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.green,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTab.index,
      items: _buildItems(),
      selectedFontSize: 12,
      unselectedFontSize: 12,
      onTap: (index) {
        onSelectTab(TabItem.values[index]);
      },
    );
  }

  List<BottomNavigationBarItem> _buildItems() {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined),
        activeIcon: const Icon(Icons.home),
        label: tabs[TabItem.main]!,
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.favorite_border),
        activeIcon: const Icon(Icons.favorite),
        label: tabs[TabItem.favorite]!,
      ),
    ];
  }
}
