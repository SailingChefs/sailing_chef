

import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../edit_profile_viewmodel.dart';

class GestureDetectorEdit extends ViewModelWidget<EditProfileViewModel> {
  const GestureDetectorEdit(this.left, this.top, {super.key});
  final double? left, top;
  @override
  Widget build(BuildContext context, EditProfileViewModel viewModel) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        Icons.photo_library,
                        color: kclightgreencolor,
                      ),
                      title: const Text('Choose from Gallery'),
                      onTap: () {
                        viewModel.getImagefromGallery();
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.camera_alt,
                        color: kclightgreencolor,
                      ),
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
        child: Container(
          height: 26.h,
          width: 26.w,
          decoration: BoxDecoration(
              color: kcwhitecolor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: kcBlackColor.withOpacity(0.05),
                  spreadRadius: 1,
                )
              ]),
          child: Icon(
            Icons.camera_alt,
            color: kcBlackColor.withOpacity(0.6),
            size: 13,
          ),
        ),
      ),
    );
  }
}
