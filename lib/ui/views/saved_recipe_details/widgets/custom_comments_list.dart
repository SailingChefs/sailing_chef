import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class CustomListTileComments extends StatelessWidget {
  final String name;
  final String date;
  final String description;
  final String image;

  const CustomListTileComments({
    super.key,
    required this.name,
    required this.date,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: 350,
            height: 270,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext contex, int index) {
                  return Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(image),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    date,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      width: 250,
                                      child: Text(
                                        description,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ],
                  );
                },
                itemCount: 2),
          ),
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tap to Rate:',
                style: globalTextStyle(
                  fontSize: 15,
                  color: kcBlackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              RatingBarIndicator(
                rating: 0,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.grey.withOpacity(0.5),
                ),
                itemCount: 5,
                itemSize: 20,
                unratedColor: Colors.grey[400],
                direction: Axis.horizontal,
              ),
            ],
          )
        ],
      ),
    );
  }
}
