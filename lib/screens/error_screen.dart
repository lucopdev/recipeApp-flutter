import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/custom_app_bar.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Erro 404',
        height: 70,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text('Pagina não encontrada.')),
        ],
      ),
    );
  }
}
