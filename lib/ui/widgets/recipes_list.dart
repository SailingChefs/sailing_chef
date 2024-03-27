import 'package:flutter/material.dart';

class RecipeeItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String time;
  final String chef;

  const RecipeeItem({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.time,
    required this.chef,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12.0),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    const Icon(
                      Icons.timer,
                      size: 12.0,
                    ),
                    const SizedBox(width: 4.0),
                    Text(time, style: const TextStyle(fontSize: 12.0)),
                    const Spacer(),
                    Text(
                      chef,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
