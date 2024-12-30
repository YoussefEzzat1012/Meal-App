import 'package:flutter/material.dart';
import './category_meal_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String id;
  final Color color;

  CategoryItem({
    required this.id,
    required this.title,
    required this.color
  });

  void selectMealItem(BuildContext context) {
    Navigator.of(context).pushNamed(Category_meal_screen.routName, arguments: {'id': id, 'title': title});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMealItem(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: Center(child: Text(title, style: Theme.of(context).textTheme.titleMedium)),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}