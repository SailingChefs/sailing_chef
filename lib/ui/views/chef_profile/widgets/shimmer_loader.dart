import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/shimmer_container.dart';

class ShimmerLoaderChefView extends StatelessWidget {
  const ShimmerLoaderChefView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      verticalSpaceSmall,
      
      GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 2,
            childAspectRatio: 7.5/9
            
            ),
        itemBuilder: (context, index) =>
            ShimmerContainer(height: 30.h, width: 20.w),
        itemCount: 6,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      )
    ]);
  }
}
