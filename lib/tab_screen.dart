import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import './main_drawer.dart';
import './meal.dart';

class TabScreen extends StatefulWidget {

  final List<Meal> favorietMeals;
  TabScreen(this.favorietMeals);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String,Object>>? _pages;
  var _selectedPageIndex = 0;

  @override
  void initState() {
    _pages = [
    {'page':CategoriesScreen(), 'title': 'Categories'},
    {'page':FavoritesScreen(widget.favorietMeals), 'title': 'Favourites'}
  ];
    super.initState();
  }

  void _selectPage(int index) {
    print(index);
    setState(() {
        _selectedPageIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          _pages?[_selectedPageIndex]['title'] as String,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      drawer: MainDrawer(),
      body: _pages?[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        //selectedFontSize: 20,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
            Icons.category,
          ),
          label: 'Category'
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(
            Icons.star,
          ),
          label: 'Favorites'
          )
        ],
      ),
    );
  }
}
