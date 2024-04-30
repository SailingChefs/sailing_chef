import 'dart:developer';

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'blocked_accounts_viewmodel.dart';

class BlockedAccountsView extends StackedView<BlockedAccountsViewModel> {
  final List<String> blockedUserList;
  const BlockedAccountsView({Key? key, required this.blockedUserList})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BlockedAccountsViewModel viewModel,
    Widget? child,
  ) {
    log(blockedUserList.length.toString());
    Size size = MediaQuery.of(context).size;
    return viewModel.isBusy
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              leadingWidth: 70,
              leading: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: Colors.grey.shade300,
                  child: Center(
                    child: IconButton(
                        onPressed: viewModel.back,
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          size: 16.r,
                        )),
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
              child: blockedUserList.isEmpty
                  ? Center(
                      child: Text(
                        "No Blocked User",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(left: 10.w, right: 0, top: 20.h),
                      itemCount: blockedUserList.length,
                      itemBuilder: ((context, index) {
                        return FutureBuilder(
                          future: viewModel.findUserDetails(
                              uid: blockedUserList[index]),
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
                                    backgroundImage: NetworkImage(
                                        blockUser!.displayPicture ?? ''),
                                  ),
                                  title: Text(
                                    blockUser.displayName ?? '',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    blockUser.bio ?? '',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      viewModel.selectMenuItem(
                                        option: value,
                                        uid: blockUser.uid.toString(),
                                      );
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'unblock',
                                        child: Text('Unblock User'),
                                      ),
                                      // const PopupMenuItem<String>(
                                      //   value: 'Option 2',
                                      //   child: Text('Option 2'),
                                      // ),
                                      // Add more PopupMenuItems for additional options
                                    ],
                                  ),
                                  // IconButton(
                                  //     padding: EdgeInsets.zero,
                                  //     onPressed: () {},
                                  //     icon: Transform.rotate(
                                  //         angle: 3.14 * 90 / 180,
                                  //         child: const Icon(
                                  //           FlutterRemix.more_fill,
                                  //         ),),),
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
