import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
import 'package:sailing_chefs/ui/views/edit_profile/edit_profile_viewmodel.dart';
import 'package:sailing_chefs/ui/views/edit_profile/widgets/gesturedector_edit.dart';

class EditProfileImage extends ViewModelWidget<EditProfileViewModel> {
  const EditProfileImage({super.key});

  @override
  Widget build(BuildContext context, EditProfileViewModel viewModel) {
    return Stack(
      children: [
        if (userDetails!.displayPicture == null &&
                viewModel.selectedImageFile == null) Container(
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
                      height: MediaQuery.sizeOf(context).height * 0.10,
                      width: MediaQuery.sizeOf(context).height * 0.10,
                      decoration: BoxDecoration(
                        color: kcWhiteColor,
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
              ) else Stack(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: kcWhiteColor,
                    backgroundImage: viewModel.selectedImageFile != null
                        ? FileImage(viewModel.selectedImageFile!)
                            as ImageProvider<Object>?
                        : ImageUtils.safeNetworkImageForAvatar(
                            userDetails!.displayPicture),
                  ),
                  const GestureDetectorEdit(68, 68),
                ],
              ),
        const GestureDetectorEdit(220, 70),
      ],
    );
  }
}
