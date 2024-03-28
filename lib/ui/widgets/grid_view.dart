import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class PrimaryGridViewCard extends StatelessWidget {
  final String foodImagePath;
  final String chefImagePath;
  final String dishName;
  final String duration;

  const PrimaryGridViewCard({
    Key? key,
    required this.foodImagePath,
    required this.dishName,
    required this.duration,
    required this.chefImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your onTap logic here
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: kcWhiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Image.asset(
                foodImagePath,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 5,
              right: 10,
              child: Container(
                width: 30.w,
                height: 30.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kcBlackColor.withOpacity(0.7),
                ),
                child: Icon(
                  Icons.bookmark_border_outlined,
                  size: 18.dg,
                  color: kcWhiteColor,
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 10,
              child: Container(
                width: 70.w,
                height: 30.h,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: kcBlackColor.withOpacity(0.7),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FlutterRemix.time_line,
                      size: 15.dg,
                      color: kcWhiteColor,
                    ),
                    Text(
                      "$duration mins",
                      style: globalTextStyle(fontSize: 12.sp),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              right: 10,
              child: Container(
                width: 35.w,
                height: 35.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kcWhiteColor,
                  border: Border.all(
                    color: kcWhiteColor,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    chefImagePath,
                    width: 35.w,
                    height: 35.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 10,
              child: Text(
                capitalizeEachWord(dishName),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: globalTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: kcBlackColor.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
