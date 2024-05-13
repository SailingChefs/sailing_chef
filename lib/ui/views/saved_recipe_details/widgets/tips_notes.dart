import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';

class TipsNotesRecipeDetails extends StatelessWidget {
  final RecipeModel viewModel;
  const TipsNotesRecipeDetails({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return viewModel.tags!.isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tips & Notes',
                style: globalTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kcBlackColor,
                ),
              ),
              verticalSpaceMedium,
              SizedBox(
                height: 40.h,
                width: screenWidth(context) - 50,
                child: ListView.builder(
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: const Color(0xff427536).withOpacity(0.16),
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Center(
                      child: Text(
                        viewModel.tags![index],
                        style: globalTextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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
              verticalSpaceMedium,
            ],
          );
  }
}
