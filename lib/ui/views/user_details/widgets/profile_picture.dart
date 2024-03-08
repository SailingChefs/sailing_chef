import 'dart:io';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/user_details/user_details_viewmodel.dart';

class ProfilePictureUserDetailsScreen
    extends ViewModelWidget<UserDetailsViewModel> {
  const ProfilePictureUserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, UserDetailsViewModel viewModel) {
    return Center(
      child: Stack(
        children: [
          viewModel.selectedImagePath == null
              ? Container(
                  height: MediaQuery.sizeOf(context).height * 0.12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        kcPrimaryColor,
                        kcPrimaryColor,
                        kcWhiteColor,
                        kcPrimaryColor,
                        kcPrimaryColor,
                        kcPrimaryColor
                      ],
                    ),
                  ),
                  child: Center(
                    child: Container(
                        height: MediaQuery.sizeOf(context).height *
                            0.11, // Adjust height to account for the border
                        width: MediaQuery.sizeOf(context).height * 0.11,
                        // Adjust width to account for the border
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: kcWhiteColor, width: 4.0.w),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              kcPrimaryColor,
                              kcPrimaryColor,
                              kcWhiteColor,
                              kcPrimaryColor,
                              kcPrimaryColor,
                            ],
                          ),
                        ),
                        child: Icon(
                          Icons.person_outlined,
                          color: kcWhiteColor,
                          size: 50.sp,
                        )),
                  ),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(
                    File(viewModel.selectedImagePath!),
                  ),
                ),
          Positioned(
            bottom: 0,
            right: 130,
            child: Container(
              height: 35,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: kcWhiteColor),
              child: IconButton(
                icon: const Icon(
                  FlutterRemix.camera_fill,
                  size: 20,
                  color: kcMediumGrey,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Choose from Gallery'),
                              onTap: () {
                                viewModel.getImagefromGallery();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text('Take a Photo'),
                              onTap: () {
                                viewModel.getImagefromCamera();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
