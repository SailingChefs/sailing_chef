import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/shimmer_container.dart';

class ShimmerDialog extends StatelessWidget {
  const ShimmerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.fitHeight,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(27), bottomLeft: Radius.circular(27)),
            child: ShimmerContainer(
              height: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.width * 0.26,
            ),
          ),
        ),
        horizontalSpaceTiny,
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 15),
                      child: ShimmerContainer(
                        height: 20,
                        width: 100,
                      )),
                  horizontalSpaceMedium,
                  const Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.star,
                          color: kclightgreencolor,
                        ),
                        ShimmerContainer(
                          height: 20,
                          width: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 8, top: 6),
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: const ShimmerContainer(
                          height: 20,
                          width: 200,
                        )),
                    // verticalSpaceSmall,
                    const ShimmerContainer(
                      height: 20,
                      width: 150,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
