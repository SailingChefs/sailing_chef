import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/edit_profile/edit_profile_viewmodel.dart';

class Description extends ViewModelWidget<EditProfileViewModel> {
  const Description({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context, EditProfileViewModel viewModel) {
  
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 500,
        minLines: 5,
        decoration: InputDecoration(
          filled: true,
          
          hintText: text,
          hintStyle: globalTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: editTextColor,
          ),
          border: InputBorder.none,
      
        ),
      ),
    );
  }
}
