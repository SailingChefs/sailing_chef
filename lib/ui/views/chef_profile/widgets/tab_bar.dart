import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/chef_profile/chef_profile_viewmodel.dart';

class TabBarChefProfileScreen extends ViewModelWidget<ChefProfileViewModel> {
  const TabBarChefProfileScreen(this.user, {super.key});
  final UserModel user;
  @override
  Widget build(BuildContext context, ChefProfileViewModel viewModel) {
    return Container(
      height: screenHeight(context) * 0.05,
      width: screenWidth(context) * 0.9,
      decoration: BoxDecoration(
        color: kcPrimaryColor.withOpacity(0.09),
        borderRadius: BorderRadius.all(Radius.circular(30.dg)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                viewModel.handleTab(0);
                viewModel.myRecipeSelected();
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTab == 'Myrecipes'
                      ? kcPrimaryColorDark
                      : Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Recipes',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: viewModel.selectedTab == 'Myrecipes'
                            ? kcVeryLightGrey
                            : kcBlackColor.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                viewModel.handleTab(1);
                viewModel.savedSelected();
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.dg),
                  ),
                  color: viewModel.selectedTab == 'Saved'
                      ? kcPrimaryColorDark
                      : Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (user.userRole == 'culinarySchool')
                      Text(
                        'Courses',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.selectedTab == 'Saved'
                              ? kcVeryLightGrey
                              : kcBlackColor.withOpacity(0.5),
                        ),
                      )
                    else
                      Text(
                        'Saved',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.selectedTab == 'Saved'
                              ? kcVeryLightGrey
                              : kcBlackColor.withOpacity(0.5),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
