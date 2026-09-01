import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/profile/profile_viewmodel.dart';

class SavedGuestButton extends ViewModelWidget<ProfileViewModel> {
  const SavedGuestButton({super.key});

  @override
  Widget build(BuildContext context, ProfileViewModel viewModel) {
    return FittedBox(
      child: Row(
        children: [
          Container(
            width: 385,
            height: 40,
            decoration: BoxDecoration(
              color: kcPrimaryColor,
              borderRadius: BorderRadius.circular(38),
            ),
            child: Center(
              child: Text(
                textAlign: TextAlign.center,
                'Saved Recipes',
                style: globalTextStyle(fontSize: 14, color: kcWhiteColor),
              ),
            ),
          ),
          IconButton(
              onPressed: viewModel.toFilterView,
              icon: const Icon(
                FlutterRemix.equalizer_line,
                color: kcPrimaryColor,
                size: 35,
              ))
        ],
      ),
    );
  }
}
