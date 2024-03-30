
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';
import '../../../../../core/imports/core_imports.dart';

class MainRecipeViewContainer extends ViewModelWidget<RecipeViewViewModel> {
  const MainRecipeViewContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              Container(
                width: double.infinity,
                height: 600,
                decoration: const BoxDecoration(
                  color: kcwhitecolor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Healthy Taco Salad',
                            style: globalTextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: kcBlackColor,
                            ),
                          ),
                        ),
                        Container(
                          width: 95,
                          height: 45,
                          padding: const EdgeInsets.all(10.0),
                          child: const Row(
                            children: [
                              Icon(
                                FlutterRemix.time_line,
                                size: 12,
                                color: kcBlackColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '20 mins',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: kcBlackColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10.0, right: 10, top: 2),
                      child: Text(
                        'This Healthy Taco Salad is the universal delight of taco night',
                        style: globalTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: kcBlackColor,
                        ),
                      ),
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
