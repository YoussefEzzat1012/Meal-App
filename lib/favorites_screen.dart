import 'package:flutter/material.dart';
import './meal.dart';
import './meal_item.dart';
class FavoritesScreen extends StatelessWidget {
  
  final List<Meal> favorietMeals;
  FavoritesScreen(this.favorietMeals);

  @override
  Widget build(BuildContext context) {

    if(favorietMeals.isEmpty){
    return Center(child: Text('Favorites Page'),);
    } else{
      return ListView.builder(
          itemBuilder: (context, index) {
            return  MealItem(
                id: favorietMeals![index].id,
                title: favorietMeals![index].title,
                affordability: favorietMeals![index].affordability,
                complexity: favorietMeals![index].complexity,
                duration: favorietMeals![index].duration,
                url: favorietMeals![index].imageUrl);
          },
          itemCount: favorietMeals!.length,
        );
    }
  }
}