import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/filter/filter_viewmodel.dart';

class TopBarFilterScreen extends ViewModelWidget<FilterViewModel> {
  const TopBarFilterScreen({super.key});

  @override
  Widget build(BuildContext context, FilterViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        horizontalSpaceSmall,
        Text(
          'Filter',
          style: globalTextStyle(
              fontSize: 20.0.dg,
              color: kcBlackColor,
              fontWeight: FontWeight.w600),
        ),
        IconButton(
          onPressed: () => viewModel.goBack(),
          icon: const Icon(
            Icons.close_rounded,
            color: kcPrimaryColor,
          ),
        ),
      ],
    );
  }
}
