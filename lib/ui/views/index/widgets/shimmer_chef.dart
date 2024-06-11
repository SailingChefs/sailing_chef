import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerChef extends StatelessWidget {
  const ShimmerChef({super.key});

  @override
  Widget build(BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
        height: screenHeight <= 680.0
                    ? screenHeight * 0.25
                    : screenHeight * 0.27,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.2),
              highlightColor: Colors.white,
              child: Container(
                width: screenWidth *  0.43,
                decoration: BoxDecoration(
                  color: kcwhitecolor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(8),
              ),
            );
          },
        ),
      ),
    );
  }
}
