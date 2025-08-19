import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

class TipsNotesRecipeDetails extends StatelessWidget {
  final RecipeModel viewModel;
  const TipsNotesRecipeDetails({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return viewModel.tags!.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recipe tags',
                style: globalTextStyle(
                  fontSize: 15.0.sp,
                  fontWeight: FontWeight.w700,
                  color: kcBlackColor,
                ),
              ),
              verticalSpaceSmall,
              SizedBox(
                height: 35.h,
                width: screenWidth(context) - 50,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    padding: EdgeInsets.symmetric(horizontal: 25.dg),
                    decoration: BoxDecoration(
                      color: const Color(0xff427536).withOpacity(0.16),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Center(
                      child: Text(
                        viewModel.tags![index],
                        style: globalTextStyle(
                          fontSize: 12.sp,
                          letterSpacing: -0.2,
                          fontWeight: FontWeight.w500,
                          color: kcBlackColor,
                        ),
                      ),
                    ),
                  ),
                  itemCount: viewModel.tags!.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                ),
              ),
              verticalSpaceSmall,
            ],
          );
  }
}
