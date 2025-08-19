import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:sailing_chefs/ui/widgets/common/grid_tile/grid_tile_model.dart';

class DraftGridTile extends StackedView<GridTileModel> {
  final String? foodImagePath;
  final String dishName;
  final void Function() onTap;
  final String recipeId;

  const DraftGridTile({
    required this.dishName, required this.onTap, required this.recipeId, super.key,
    this.foodImagePath,
  });

  @override
  Widget builder(
    BuildContext context,
    GridTileModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: 15.0.dg),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0.r),
                        topRight: Radius.circular(15.0.r),
                      ),
                      child: Image.network(
                        foodImagePath!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
                ),
                verticalSpaceTiny,
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
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
          ],
        ),
      ),
    );
  }

  @override
  GridTileModel viewModelBuilder(
    BuildContext context,
  ) =>
      GridTileModel();
}
