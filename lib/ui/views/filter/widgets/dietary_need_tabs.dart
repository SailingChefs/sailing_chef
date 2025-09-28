import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/filter/filter_viewmodel.dart';

class DietaryNeedTabsFilterScreen extends ViewModelWidget<FilterViewModel> {
  const DietaryNeedTabsFilterScreen({super.key});

  @override
  Widget build(BuildContext context, FilterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dietary Needs',
          style:
              globalTextStyle(fontSize: 20.0.dg, color: kcBlackColor, fontWeight: FontWeight.w500),
        ),
        verticalSpaceSmall,
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            // Main dietary tags
            _DietaryTagChip(
              label: 'Vegetarian',
              selected: viewModel.isVegetarianSelected,
              onTap: () => viewModel.handleMainTabsDietary(0),
            ),
            _DietaryTagChip(
              label: 'Vegan',
              selected: viewModel.isVeganSelected,
              onTap: () => viewModel.handleMainTabsDietary(1),
            ),
            _DietaryTagChip(
              label: 'Gluten-Free',
              selected: viewModel.isGlutenFreeSelected,
              onTap: () => viewModel.handleMainTabsDietary(2),
            ),
            _DietaryTagChip(
              label: 'Dairy-Free',
              selected: viewModel.isDairyFreeSelected,
              onTap: () => viewModel.handleMainTabsDietary(3),
            ),
            // Sub dietary tags
            _DietaryTagChip(
              label: 'Nut-Free',
              selected: viewModel.isNutFreeSelected,
              onTap: () => viewModel.handleSubTabsDietary(0),
            ),
            _DietaryTagChip(
              label: 'Pescatarian',
              selected: viewModel.isPescatarianSelected,
              onTap: () => viewModel.handleSubTabsDietary(1),
            ),
            _DietaryTagChip(
              label: 'Kosher',
              selected: viewModel.isKosherSelected,
              onTap: () => viewModel.handleSubTabsDietary(2),
            ),
            _DietaryTagChip(
              label: 'Halal',
              selected: viewModel.isHalalSelected,
              onTap: () => viewModel.handleSubTabsDietary(3),
            ),
          ],
        ),
      ],
    );
  }
}

class _DietaryTagChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DietaryTagChip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.dg, vertical: 12.dg),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.dg),
          ),
          color: selected ? kcPrimaryColor : kcVeryLightGrey.withOpacity(0.4),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: selected ? kcVeryLightGrey : kcBlackColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
