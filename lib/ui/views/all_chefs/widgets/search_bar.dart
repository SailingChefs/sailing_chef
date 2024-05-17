import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/user_model.dart';
import 'package:sailing_chefs/ui/views/all_chefs/all_chefs_viewmodel.dart';

class SearchBarAllChefsScreen extends ViewModelWidget<AllChefsViewModel> {
  final List<UserModel> chefs;
  const SearchBarAllChefsScreen({super.key, required this.chefs});

  @override
  Widget build(BuildContext context, AllChefsViewModel viewModel) {
    return SizedBox(
      height: 40.h,
      child: TextField(
        controller: viewModel.searchController,
        onChanged: (value) => viewModel.rebuildUi(),
        textAlign: TextAlign.start,
        
        decoration: InputDecoration(
          
          hintStyle: TextStyle(
            color: kcBlackColor.withOpacity(0.6),
            fontSize: 12.sp,

          ),
          
          
          filled: true,
          fillColor: kcPrimaryColor.withOpacity(0.2),
          labelStyle:
              TextStyle(fontSize: 12.sp, color: kcBlackColor.withOpacity(0.6)),
          labelText: 'Search',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0.r),
            borderSide: BorderSide(color: kcWhiteColor.withOpacity(0.2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0.r),
            borderSide: BorderSide(color: kcWhiteColor.withOpacity(0.2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0.r),
            borderSide: BorderSide(
                color: kcWhiteColor.withOpacity(0.2)), // Unfocused border color
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0.r),
            borderSide: const BorderSide(
              color: kcErrorColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0.r),
            borderSide: const BorderSide(
              color: kcErrorColor,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            // vertical: 10.0,
            horizontal: 20.0,
          ),
          prefixIcon: GestureDetector(
            onTap: () => viewModel.searchUsers(chefs),
            child: Icon(
              FlutterRemix.search_line,
              color: kcBlackColor.withOpacity(0.6),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
