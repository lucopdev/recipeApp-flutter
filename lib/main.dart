import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/common/app_routes.dart';
import 'package:recipe_app/common/my_colors.dart';
import 'package:recipe_app/screens/categories_meals_screen.dart';
import 'package:recipe_app/screens/error_screen.dart';
import 'package:recipe_app/screens/meal_detail_screen.dart';
import 'package:recipe_app/screens/settings_screen.dart';
import 'package:recipe_app/screens/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case AppRoutes.HOME:
            return _buildPageRoute(const TabsScreen(), settings);
          case AppRoutes.CATEGORIES_MEALS:
            return _buildPageRoute(const CategoriesMealsScreen(), settings);
          case AppRoutes.MEAL_DETAIL:
            return _buildPageRoute(const MealDetailScreen(), settings);
          case AppRoutes.SETTINGS:
            return _buildPageRoute(const SettingsScreen(), settings);
          default:
            return null;
        }
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
      },
    );
  }
}

PageRoute _buildPageRoute(Widget page, RouteSettings settings) {
  return PageRouteBuilder(
      settings: settings,
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
