import 'package:flutter/material.dart';
import 'package:meal_app/meal.dart';
import './dummy_data.dart';

class MealDetails extends StatelessWidget {

  static const routName = '\meal_detail';
  final Function toggleFavorites;
  final Function isFavorite;
  MealDetails(this.toggleFavorites, this.isFavorite);



  Widget buidlSectionTitle(String title, BuildContext context) {
      return  Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(title, style: Theme.of(context).textTheme.titleMedium,),
            );
  }

  Widget buildContainer(BuildContext context, Widget child) {
    return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                border: Border.all(color: Colors.grey, width: 3),
                borderRadius: BorderRadius.circular(15)
              ),
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.all(10),
              height: 200,
              width: 300,
              child: child,
    );
  }
  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(selectedMeal.title)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buidlSectionTitle('Ingredients', context),
            buildContainer(context, ListView.builder(
                itemBuilder: (ctx, index) {
                 return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${selectedMeal.ingredients[index]}'),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),),
            buidlSectionTitle('Steps', context),
            buildContainer(
              context,
              ListView.builder(
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                    leading: CircleAvatar(child: Text('#${index + 1}'),),
                    title: Text(selectedMeal.steps[index]),
                  ),
                 Divider(color: Colors.grey,),
                  ]
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId as String) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavorites(mealId),
      ),
    );
  }
}