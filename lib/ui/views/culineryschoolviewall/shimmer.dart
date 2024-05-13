import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/shimmer_container.dart';

class ShimmerLoaderCulinarySchool extends StatelessWidget {
  const ShimmerLoaderCulinarySchool({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            height: 113.h,
            // width: 38.w,
            margin: EdgeInsets.only(bottom: 10.h),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(10, 66, 117, 54),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                ShimmerContainer(
                  height: screenHeight(context),
                  width: 113.w,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShimmerContainer(
                        height: 15.h,
                        width: 140.w,
                      ),
                      ShimmerContainer(
                        height: 15.h,
                        width: 120.w,
                      ),
                      ShimmerContainer(
                        height: 15.h,
                        width: 110.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
