import 'package:flutter/material.dart';
import 'screens/category_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './models/meal.dart';
import './dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _favouriteMeals = [];

  List<Meal> _availableMeals = DUMMY_MEALS;
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((element) {
        if (_filters["gluten"] && !element.isGlutenFree) {
          return false;
        }
        if (_filters["lactose"] && !element.isLactoseFree) {
          return false;
        }
        if (_filters["vegan"] && !element.isVegan) {
          return false;
        }
        if (_filters["vegetarian"] && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favouriteMeals.indexWhere((element) => element.id == mealId);
    setState(() {
      if (existingIndex >= 0) {
        _favouriteMeals.removeAt(existingIndex);
      } else {
        _favouriteMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      }
    });
  }

  bool _isMealFavourite(String mealId) {
    return _favouriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FoodApp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.deepPurpleAccent,
        fontFamily: 'ArchitectsDaughter',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
                fontFamily: 'ArchitectsDaughter',
                fontSize: 20,
                fontWeight: FontWeight.w900),
            bodyText2: TextStyle(
                fontFamily: 'MavenPro',
                fontSize: 15,
                fontWeight: FontWeight.w900),
            headline6: TextStyle(
              fontFamily: 'ArchitectsDaughter',
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.deepPurple,
            )),
      ),
      routes: {
        '/': (_) => TabsScreen(_favouriteMeals),
        CategoryMealsScreen.routeName: (_) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (_) =>
            MealDetailScreen(_toggleFavourite, _isMealFavourite),
        FiltersScreen.routeName: (_) => FiltersScreen(_filters, _setFilters)
      },
      // onGenerateRoute: (settings) {
      //   print(settings.name);
      //   return MaterialPageRoute(builder: (ctx) => MealDetailScreen());
      // },
      // onUnknownRoute: (settings) {
      //   print(settings.name);
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => MealDetailScreen());
      // },
    );
  }
}
