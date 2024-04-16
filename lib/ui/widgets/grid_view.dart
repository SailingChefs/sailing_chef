import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class PrimaryGridViewCard extends  StatelessWidget{
  final String foodImagePath;
  final String chefImagePath;
  final String dishName;
  final String duration;
  final void Function() onTap;

  const PrimaryGridViewCard({
    Key? key,
    required this.foodImagePath,
    required this.dishName,
    required this.duration,
    required this.chefImagePath, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0.r),
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
              borderRadius:
              BorderRadius.only(
                topLeft: Radius.circular(15.0.r),
                topRight: Radius.circular(15.0.r),
              ),
              child: Image.network(
                foodImagePath,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.19.h,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 5.dg,
              right: 10.dg,
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
              bottom: 35.dg,
              left: 10.dg,
              child: Container(
                width: 70.w,
                height: 25.h,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: kcBlackColor.withOpacity(0.7),
                  borderRadius:  BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FlutterRemix.time_line,
                      size: 12.dg,
                      color: kcWhiteColor,
                    ),
                    Text(
                      duration,
                      style: globalTextStyle(fontSize: 10.sp),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 18.dg,
              right: 10.dg,
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
                  borderRadius: BorderRadius.circular(30.0.r),
                  child: Image.network(
                    chefImagePath,
                    width: 35.w,
                    height: 35.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 6.dg,
              left: 8.dg,
              child: Text(
                capitalizeEachWord(dishName),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: globalTextStyle(
                  fontSize: 13.sp,
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
