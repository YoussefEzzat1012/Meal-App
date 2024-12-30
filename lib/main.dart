import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import './categories_screen.dart';
import './category_meal_screen.dart';
import './meal_detail_screen.dart';
import './tab_screen.dart';
import 'filtter_screen.dart';
import './meal.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

   List<Meal> _availableMeals = DUMMY_MEALS; 
   List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filtersData) {

      setState(() {
        _filters = filtersData;

        _availableMeals = DUMMY_MEALS.where((meal) {
      // Example logic to filter meals based on filtersData
      // Return true or false to indicate if the meal should be included
      if (_filters['gluten']! && !meal.isGlutenFree) {
        return false;
      }
      if (_filters['lactose']! && !meal.isLactoseFree) {
        return false;
      }
      if (_filters['vegetarian']! && !meal.isVegetarian) {
        return false;
      }
      if (_filters['vegan']! && !meal.isVegan) {
        return false;
      }
      
      return true; // Return true if the meal passes all filter checks
    }).toList();
      });
  }

  void _toggleFavorites(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((meal) => mealId == meal.id);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else{
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId)
        );
      });
    }
  }

  bool _isFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
        ).copyWith(
          secondary: Colors.amber,
          tertiary: Colors.white
        ),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          )
        )
      ),
      //home: CategoriesScreen(),
      //initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(_favoriteMeals),
        Category_meal_screen.routName : (ctx) => Category_meal_screen(_availableMeals),
        MealDetails.routName : (ctx) => MealDetails(_toggleFavorites, _isFavorite),
        FiltterScreen.routeName: (ctx) => FiltterScreen(_filters, _setFilters)

      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => TabScreen());
      // },

      onUnknownRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => TabScreen(_favoriteMeals));
      },

      
      
    );
  }
}