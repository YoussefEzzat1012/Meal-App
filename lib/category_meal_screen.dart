import 'package:flutter/material.dart';
import 'package:meal_app/meal.dart';
import './dummy_data.dart';
import './meal_item.dart';

class Category_meal_screen extends StatefulWidget {
  // final String title;
  // final String id;
  // Category_meal_screen(this.title, this.id);
  static const routName = '/category_meal';
  final List<Meal> _availableMeals;
  Category_meal_screen(this._availableMeals);

  @override
  State<Category_meal_screen> createState() => _Category_meal_screenState();
}

class _Category_meal_screenState extends State<Category_meal_screen> {
  
  String? categoryTitle;
  List<Meal>? displayedMeals;
  bool _isLoadedInitData = false;

  @override
  void didChangeDependencies() {
    if(!_isLoadedInitData) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, Object>?;
    if (arguments != null) {
      categoryTitle = arguments['title'] as String;
      final id = arguments['id'] as String;
      displayedMeals = widget._availableMeals.where((meal) {
        return meal.categories.contains(id);
      }).toList();
    }
    _isLoadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeItem(String id) {
    setState(() {
      displayedMeals?.removeWhere((meal) => meal.id == id);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle as String),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return  MealItem(
                 id: displayedMeals![index].id,
                title: displayedMeals![index].title,
                affordability: displayedMeals![index].affordability,
                complexity: displayedMeals![index].complexity,
                duration: displayedMeals![index].duration,
                url: displayedMeals![index].imageUrl);
          },
          itemCount: displayedMeals!.length,
        ));
  }
}
