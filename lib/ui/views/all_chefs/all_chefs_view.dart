import 'package:sailing_chefs/core/imports/core_imports.dart';

import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/all_chefs/widgets/chef_list.dart';
import 'package:sailing_chefs/ui/views/all_chefs/widgets/search_bar.dart';
import 'package:sailing_chefs/ui/views/all_chefs/widgets/search_list.dart';
import 'package:sailing_chefs/ui/views/all_chefs/widgets/topbar.dart';

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
          appBar: const TopBarMeetChefsScreen(),
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
