
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double? height;
  final double? width;
  const ShimmerContainer({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.2),
            highlightColor: Colors.white,
            child: Container(
              width: width?? 150.w,
              height: height ?? 20.h,
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
  }
}