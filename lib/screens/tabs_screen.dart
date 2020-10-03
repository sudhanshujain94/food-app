import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;
  TabsScreen(this.favouriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'pageTitle': 'Categories'},
      {
        'page': FavoritesScreen(widget.favouriteMeals),
        'pageTitle': 'Favourites'
      },
    ];
    super.initState();
  }

  void _selectePage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]["pageTitle"]),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]["page"],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        onTap: _selectePage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            title: Text(
              "category",
            ),
            icon: Icon(
              Icons.category,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(
              "Favorites",
            ),
            icon: Icon(
              Icons.favorite,
            ),
          ),
        ],
      ),
    );
  }
}
