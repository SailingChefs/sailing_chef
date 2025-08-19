import 'package:flutter/rendering.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoaderAllRecipes extends StatelessWidget {
  const ShimmerLoaderAllRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return ShrinkWrappingViewport(
            offset: ViewportOffset.zero(),
            slivers: [
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 18.0,
                  childAspectRatio: 7.4 / 9,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.2),
                      highlightColor: Colors.white,
                      child: Container(
                        width: 240.w,
                        decoration: BoxDecoration(
                          color: kcwhitecolor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                  childCount: 8,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
