import 'package:flutter/material.dart';

class TopBarRecipeView extends StatelessWidget {
  const TopBarRecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/burger.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
