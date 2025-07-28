import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'blocked_accounts_viewmodel.dart';

class BlockedAccountsView extends StackedView<BlockedAccountsViewModel> {
  const BlockedAccountsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BlockedAccountsViewModel viewModel,
    Widget? child,
  ) {
    Size size = MediaQuery.of(context).size;
    return viewModel.isBusy
        ? const Center(
            child: CircularProgressIndicator(
            color: kcPrimaryColor,
          ))
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              leading: Padding(
                padding: EdgeInsets.only(left: 8.0.w),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: viewModel.back,
                  child: Container(
                    alignment: Alignment.center,
                    height: 26.h,
                    width: 26.w,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: kcBlackColor,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
              centerTitle: true,
              title: Text(
                "Blocked Accounts",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: SizedBox(
              height: size.height,
              width: size.width,
              // padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: viewModel.blockedUsers.isEmpty
                  ? Center(
                      child: Text(
                        "No Blocked User",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(left: 10.w, right: 0, top: 20.h),
                      itemCount: viewModel.blockedUsers.length,
                      itemBuilder: ((context, index) {
                        return FutureBuilder(
                          future: viewModel.findUserDetails(
                              uid: viewModel.blockedUsers[index]),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text('');
                            } else if (snapshot.data == null) {
                              return Center(
                                child: Text(
                                  "No Blocked User",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.sp),
                                ),
                              );
                            } else {
                              var blockUser = snapshot.data;
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 24.r,
                                    backgroundImage: ImageUtils.safeNetworkImageForAvatar(
                                      blockUser!.displayPicture,
                                    ),
                                  ),
                                  title: Text(
                                    blockUser.displayName ?? '',
                                    style: globalTextStyle(
                                        fontSize: 12.sp,
                                        color: kcBlackColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  subtitle: SizedBox(
                                    height: 20.h,
                                    child: Text(
                                      blockUser.bio ?? '',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: globalTextStyle(
                                          fontSize: 12.sp,
                                          color: kcBlackColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  trailing: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      viewModel.selectMenuItem(
                                        option: value,
                                        user: blockUser,
                                      );
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'unblock',
                                        child: Text('Unblock User'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          }),
                        );
                      }),
                    ),
            ),
          );
  }

  @override
  void onViewModelReady(BlockedAccountsViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  BlockedAccountsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      BlockedAccountsViewModel();
}
