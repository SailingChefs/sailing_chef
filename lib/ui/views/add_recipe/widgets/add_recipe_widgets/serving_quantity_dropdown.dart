import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class ServingQuantity extends ViewModelWidget<AddRecipeViewModel> {
  const ServingQuantity(this.drafts, {super.key});
  final RecipeModel? drafts;

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Serving',
              style: globalTextStyle(
                fontSize: 14.sp,
                letterSpacing: -0.5,
                fontWeight: FontWeight.w600,
                color: kcBlackColor,
              ),
            ),
            horizontalSpaceTiny,
            Text(
              '*',
              style: globalTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: kcErrorColor),
            ),
          ],
        ),
        verticalSpaceSmall,
        Container(
          width: 105.w,
          padding: EdgeInsets.symmetric(
            horizontal: 10.0.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0.r),
            color: kcPrimaryColor.withOpacity(0.07),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter serving quantity';
                    }

                    return null;
                  },
                  controller: viewModel.servingSize,
                  keyboardType: TextInputType.number,
                  cursorColor: kcPrimaryColor,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3)
                  ],
                  decoration: InputDecoration(
                    hintText: '1',
                    hintStyle: globalTextStyle(
                      fontSize: 14.sp,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w300,
                      color: kcBlackColor.withOpacity(0.5),
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0.r),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0.r),
                      borderSide: BorderSide(
                        color: kcPrimaryColor.withOpacity(0.01),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0.r),
                        borderSide: BorderSide(
                          color: kcPrimaryColor.withOpacity(0.01),
                        )),
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
                    prefixIcon: Icon(
                      FlutterRemix.group_line,
                      color: kcBlackColor.withOpacity(0.5),
                      size: 16.0.dg,
                    ),
                    // contentPadding: EdgeInsets.only(l),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
