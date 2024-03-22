import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final bool bottom;

  const CustomAppBar({
    this.bottom = true,
    required this.title,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
              title,
            ),
          ),
          const SizedBox(
            width: 56,
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      bottom: bottom
          ? TabBar(
              labelColor: Colors.white,
              labelStyle: Theme.of(context).textTheme.bodyMedium,
              unselectedLabelColor: const Color.fromARGB(255, 255, 145, 145),
              indicatorColor: Colors.white,
              indicatorWeight: 4,
              indicatorPadding: const EdgeInsets.only(bottom: 2),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: const [
                Tab(
                  icon: Icon(
                    Icons.category,
                  ),
                  text: 'Categorias',
                ),
                Tab(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  text: 'Favoritos',
                ),
              ],
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
