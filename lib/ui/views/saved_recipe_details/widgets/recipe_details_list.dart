import 'package:flutter/material.dart';

class RecipeDetailsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: 139,
      height: 179,
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(22.7),
            bottomLeft: Radius.circular(22.7),
          ),
        ),
        color: Colors.grey[200],
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image(image: AssetImage('assets/images/icons/dp.jpg')),
                  SizedBox(width: 8),
                  Text(
                    'Shiitaki Mushroom ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Risotto',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
