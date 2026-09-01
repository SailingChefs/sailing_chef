import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/search/search_viewmodel.dart';

class ExploreAllButtonSearch extends ViewModelWidget<SearchViewModel> {
  final String text;
  final void Function()? onTap;
  const ExploreAllButtonSearch({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context, SearchViewModel viewModel) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 203,
        height: 48,
        decoration: BoxDecoration(
          color: kcPrimaryColorDark,
          borderRadius: BorderRadius.circular(38),
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            text,
            style: globalTextStyle(fontSize: 14, color: kcWhiteColor),
          ),
        ),
      ),
    );
  }
}
