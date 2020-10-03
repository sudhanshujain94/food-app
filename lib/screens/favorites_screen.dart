import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  FavoritesScreen(this.favoriteMeals);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  void _changeIt() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMeals.isEmpty) {
      return Center(
        child: Text("You have no favourite Yet"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: widget.favoriteMeals[index].id,
            affordability: widget.favoriteMeals[index].affordability,
            complexity: widget.favoriteMeals[index].complexity,
            duration: widget.favoriteMeals[index].duration,
            imageUrl: widget.favoriteMeals[index].imageUrl,
            title: widget.favoriteMeals[index].title,
            changeIt: _changeIt,
          );
        },
        itemCount: widget.favoriteMeals.length,
      );
    }
  }
}
