import 'package:flutter/material.dart';
import 'package:recipe_app/common/app_routes.dart';
import 'package:recipe_app/common/my_colors.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget _createIcon(IconData icon, String label, Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.yellow,
            width: double.infinity,
            height: 120,
            padding: const EdgeInsets.only(top: 35),
            child: const Text(
              'Vamos Cozinhar?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: MyColors.mainColor,
              ),
            ),
          ),
          _createIcon(Icons.restaurant, 'Refeições',
              () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME)),
          _createIcon(
              Icons.settings,
              'Configurações',
              () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.SETTINGS)),
        ],
      ),
    );
  }
}
