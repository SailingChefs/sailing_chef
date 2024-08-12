import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'discard_sheet_model.dart';

class DiscardSheet extends StackedView<DiscardSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const DiscardSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DiscardSheetModel viewModel,
    Widget? child,
  ) {
    final RecipeModel recipe = request.data['model'];
    final images = request.data['images'];
    final path = request.data['path'];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: kcWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpaceMedium,
          Text(
            'Discard edits?',
            style: globalTextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, color: kcBlackColor),
          ),
          verticalSpaceMedium,
          Text(
            textAlign: TextAlign.center,
            'If you go back now,\n you’ll lose all the edits you’ve made.',
            style: globalTextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: kcBlackColor.withOpacity(0.87),
            ),
          ),
          verticalSpaceMedium,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
              onTap: viewModel.discardButton,
              child: Container(
                height: 40,
                width: 170,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                    color: kcWhiteColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: kcErrorColor,
                    )),
                child: Center(
                  child: Text(
                    'Discard',
                    style: globalTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: kcPrimaryColorDark,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                completer!(SheetResponse(confirmed: true));
                viewModel.saveButton(recipe, images, path);
              },
              child: Container(
                height: 40,
                width: 170,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: kcPrimaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'Save drafts',
                    style: globalTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: kcWhiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }

  @override
  DiscardSheetModel viewModelBuilder(BuildContext context) =>
      DiscardSheetModel();
}
