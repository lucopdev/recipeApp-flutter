import 'package:flutter/material.dart';
import 'package:recipe_app/common/my_colors.dart';
import 'package:recipe_app/models/meal.dart';
import 'package:recipe_app/widgets/custom_app_bar.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({super.key});

  Widget _createListView(Widget child) {
    return child;
  }

  void _favoriteRecipe() {}

  Widget _createContainerTitleAndList(
      BuildContext context, String title, Widget child) {
    return Container(
      width: 350,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Color.fromARGB(106, 96, 125, 139),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 0))
      ]),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          _createListView(child),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;

    return Scaffold(
      appBar:
          CustomAppBar(title: meal.title.toString(), height: 70, bottom: false),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Image.network(
                  meal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      meal.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.schedule),
                            const SizedBox(width: 6),
                            Text('${meal.duration.toString()} min'),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.work_outline),
                            const SizedBox(width: 6),
                            Text(meal.complexityText),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.attach_money),
                            const SizedBox(width: 6),
                            Text(meal.costText),
                          ],
                        ),
                      ],
                    ),
                  ),
                  _createContainerTitleAndList(
                    context,
                    'Ingredientes',
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: meal.ingredients.length,
                      itemBuilder: (ctx, index) {
                        return Card(
                          color: MyColors.secondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(width: 1),
                          ),
                          margin: const EdgeInsets.all(3.0),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              meal.ingredients[index],
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _createContainerTitleAndList(
                    context,
                    'Modo de preparo',
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: meal.steps.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            const Divider(),
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: MyColors.mainColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    (index + 1).toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                              title: Text(meal.steps[index].toString(),
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _favoriteRecipe,
        elevation: 8,
        shape: const CircleBorder(),
        backgroundColor: MyColors.background,
        child: const Icon(
          Icons.favorite,
          color: MyColors.mainColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
