import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/all_chefs/all_chefs_viewmodel.dart';

class SearchBarAllChefsScreen extends ViewModelWidget<AllChefsViewModel> {
  const SearchBarAllChefsScreen({super.key});

  @override
  Widget build(BuildContext context, AllChefsViewModel viewModel) {
    return SizedBox(
      height: 40.h,
      child: TextField(
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
            vertical: 10.0,
            horizontal: 20.0,
          ),
          prefixIcon: Icon(
            FlutterRemix.search_line,
            color: kcBlackColor.withOpacity(0.6),
            size: 20,
          ),
        ),
      ),
    );
  }
}
