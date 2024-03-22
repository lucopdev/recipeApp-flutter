import 'package:flutter/material.dart';
import 'package:recipe_app/common/my_colors.dart';
import 'package:recipe_app/screens/categories_screen.dart';
import 'package:recipe_app/screens/favorite_screen.dart';
import 'package:recipe_app/widgets/custom_app_bar.dart';
import 'package:recipe_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  final List<Map<String, Object>> _screens = [
    {'title': 'Categorias', 'screen': const CategoriesScreen()},
    {'title': 'Favoritos', 'screen': const FavoriteScreen()},
  ];

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _screens[_selectedScreenIndex]['title'].toString(),
        height: 70,
        bottom: false,
      ),
      drawer: const MainDrawer(),
      body: _screens[_selectedScreenIndex]['screen']! as Widget,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedScreenIndex,
        unselectedItemColor: MyColors.unselectedColor,
        selectedItemColor: Colors.white,
        backgroundColor: MyColors.mainColor,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
            backgroundColor: MyColors.mainColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
            backgroundColor: MyColors.mainColor,
          )
        ],
      ),
    );
  }
}
