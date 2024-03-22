import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/common/app_routes.dart';
import 'package:recipe_app/common/my_colors.dart';
import 'package:recipe_app/data/dummy_data.dart';
import 'package:recipe_app/models/meal.dart';
import 'package:recipe_app/models/settings.dart';
import 'package:recipe_app/screens/categories_meals_screen.dart';
import 'package:recipe_app/screens/error_screen.dart';
import 'package:recipe_app/screens/meal_detail_screen.dart';
import 'package:recipe_app/screens/settings_screen.dart';
import 'package:recipe_app/screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();
  List<Meal> _avaliableMeals = DUMMY_MEALS;
  final List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;

      _avaliableMeals = DUMMY_MEALS.where((meal) {
        final filterGlutten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGlutten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      if (_favoriteMeals.contains(meal)) {
        _favoriteMeals.remove(meal);
      } else {
        _favoriteMeals.add(meal);
      }
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    final ThemeData theme = ThemeData();

    return MaterialApp(
      theme: theme.copyWith(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: MyColors.unselectedColor,
          ),
        ),
        colorScheme: theme.colorScheme.copyWith(
          background: MyColors.background,
          primary: MyColors.mainColor,
          shadow: MyColors.splashShadowColor,
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Raleway',
          ),
          bodyLarge: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.w700,
          ),
          titleMedium: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.w700,
          ),
          bodySmall: const TextStyle(
            color: MyColors.splashShadowColor,
            fontSize: 15,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      onGenerateRoute: (RouteSettings routeSettings) {
        switch (routeSettings.name) {
          case AppRoutes.HOME:
            return _buildPageRoute(
                TabsScreen(favouriteMeals: _favoriteMeals), routeSettings);
          case AppRoutes.CATEGORIES_MEALS:
            return _buildPageRoute(
                CategoriesMealsScreen(meals: _avaliableMeals), routeSettings);
          case AppRoutes.MEAL_DETAIL:
            return _buildPageRoute(
                MealDetailScreen(
                  toggleFavorite: _toggleFavorite,
                  isFavorite: _isFavorite,
                ),
                routeSettings);
          case AppRoutes.SETTINGS:
            return _buildPageRoute(
                SettingsScreen(
                    settings: settings, onSettingsChanged: _filterMeals),
                routeSettings);
          default:
            return null;
        }
      },
      onUnknownRoute: (routeSettings) {
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
      },
    );
  }
}

PageRoute _buildPageRoute(Widget page, RouteSettings routeSettings) {
  return PageRouteBuilder(
      settings: routeSettings,
      transitionDuration: const Duration(milliseconds: 120),
      reverseTransitionDuration: const Duration(milliseconds: 120),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      });
}
