// ignore_for_file: prefer_const_constructors

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
        child: Container(
          height: 20.h,
          width: 20.w,
          decoration: const BoxDecoration(
            color: kcPrimaryColor,
            shape: BoxShape.rectangle,
          ),
          child: Icon(
            Icons.edit_outlined,
            color: kcwhitecolor,
            size: 15,
          ),
        ),
      ),
    );
  }
}
