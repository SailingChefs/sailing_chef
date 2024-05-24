import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/all_chefs/widgets/chef_list.dart';
import 'package:sailing_chefs/ui/views/all_chefs/widgets/search_bar.dart';
import 'package:sailing_chefs/ui/views/all_chefs/widgets/search_list.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

import 'all_chefs_viewmodel.dart';

class AllChefsView extends StackedView<AllChefsViewModel> {
  final List<UserModel> chefList;
  AllChefsView({Key? key, required this.chefList}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget builder(
    BuildContext context,
    AllChefsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kcBackgroundColor,
          appBar: AppBar(
              backgroundColor: kcBackgroundColor,
              elevation: 0,
              title: Text(
                'Meet Your Chefs',
                style: globalTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kcBlackColor),
              ),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BackArrowWidget(
                  onTap: viewModel.toHomeView,
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                verticalSpaceSmall,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SearchBarAllChefsScreen(
                    chefs: chefList,
                  ),
                ),
                verticalSpace(13),
                viewModel.searchController.text.isEmpty
                    ? ChefList(chefList: chefList)
                    : SearchListAllChefs(chefs: chefList),
              ],
            ),
          )),
    );
  }

  @override
  AllChefsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AllChefsViewModel();
}
