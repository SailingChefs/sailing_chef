import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/all_chefs/all_chefs_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/empty_state.dart';

class ChefList extends ViewModelWidget<AllChefsViewModel> {
  final List<UserModel> chefList;
  const ChefList({super.key, required this.chefList});

  @override
  Widget build(BuildContext context, AllChefsViewModel viewModel) {
    return Expanded(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (chefList.isEmpty) {
          return const AppEmptyState(
            icon: Icons.location_on_outlined,
            title: 'No chefs in this area yet',
            subtitle: 'Be the first to drop a pin.',
          );
        }

        return CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 5.0,
                childAspectRatio: 7.5 / 9,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      viewModel.toChefProfile(chefList[index]);
                    },
                    child: Container(
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: kcWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: kcBlackColor.withOpacity(0.08),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.r),
                              topRight: Radius.circular(12.r),
                            ),
                            child: chefList[index].displayPicture == ''
                                ? Image.asset(
                                    'assets/images/misc/blank_image.png',
                                    fit: BoxFit.cover,
                                    height: 200,
                                  )
                                : Image.network(
                                    chefList[index].displayPicture!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                          )),
                          Padding(
                            padding: EdgeInsets.only(left: 13.0.dg, top: 10),
                            child: Text(
                              capitalizeEachWord(chefList[index].displayName!),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 13.0.dg, bottom: 10),
                            child: Text(
                              capitalizeEachWord(
                                chefList[index].recipes!.isEmpty
                                    ? ('no dishes')
                                    : ("${chefList[index].recipes!.length}  Dishes"),
                              ),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: kcBlackColor.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: chefList.length,
              ),
            ),
          ],
        );
      }),
    );
  }
}
