import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';

import 'share_recipe_to_sailing_cheff_user_viewmodel.dart';

class ShareRecipeToSailingCheffUserView
    extends StackedView<ShareRecipeToSailingCheffUserViewModel> {
  final Uri link;
  const ShareRecipeToSailingCheffUserView({required this.link, Key? key})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShareRecipeToSailingCheffUserViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kclightgreencolor,
        // leadingWidth: 40.w,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20).w,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const CircleAvatar(
              backgroundColor: Color.fromARGB(255, 40, 116, 90),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Share with S.C Users",
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: viewModel.allusers.length,
            itemBuilder: (context, index) {
              final user = viewModel.allusers[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16).h,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24.r,
                    backgroundImage: ImageUtils.safeNetworkImageForAvatar(
                      user.displayPicture?.toString(),
                    ),
                  ),
                  title: Text(
                    user.displayName.toString(),
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    user.email.toString(),
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal),
                  ),
                  trailing: InkWell(
                    onTap: () {
                      showIndicator(context);
                      viewModel.sendLinkToSailingChefUser(user, link);
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: kclightgreencolor,
                      child: Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: 16.r,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  showIndicator(BuildContext context) {
    return showDialog(
        context: context,
        builder: (builder) {
          return const Material(
            type: MaterialType.transparency,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        });
  }

  @override
  void onViewModelReady(ShareRecipeToSailingCheffUserViewModel viewModel) {
    viewModel.onViewModelReady();
    super.onViewModelReady(viewModel);
  }

  @override
  ShareRecipeToSailingCheffUserViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ShareRecipeToSailingCheffUserViewModel();
}
