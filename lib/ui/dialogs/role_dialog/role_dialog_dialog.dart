import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sailing_chefs/ui/common/app_colors.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'role_dialog_dialog_model.dart';

const double _graphicSize = 60;

class RoleDialogDialog extends StackedView<RoleDialogDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const RoleDialogDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RoleDialogDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Container(
        height: screenHeight(context) * 0.08,
        decoration: BoxDecoration(
          color: const Color(0xFFF4F8F7).withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  viewModel.handleSignUpAs(2);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: viewModel.selectedSignUpAs == 'chef'
                        ? kcPrimaryColor
                        : kcwhitecolor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 14,
                        height: 14,
                        child: SvgPicture.asset(
                          'assets/images/icons/hat.svg',
                          color: viewModel.selectedSignUpAs == 'chef'
                              ? kcwhitecolor
                              : kcPrimaryColor,
                        ),
                      ),
                      verticalSpaceTiny,
                      Text(
                        'Chef',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.selectedSignUpAs == 'chef'
                              ? kcWhiteColor
                              : kcPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () => viewModel.handleSignUpAs(1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        width: 2,
                        color: kcWhiteColor.withOpacity(0.2),
                      ),
                      left: BorderSide(
                        width: 2,
                        color: kcWhiteColor.withOpacity(0.2),
                      ),
                    ),
                    color: viewModel.selectedSignUpAs == 'culinarySchool'
                        ? kcPrimaryColor
                        : kcwhitecolor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: SvgPicture.asset(
                          'assets/images/icons/school.svg',
                          color: viewModel.selectedSignUpAs == 'culinarySchool'
                              ? kcwhitecolor
                              : kcPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Culinary school',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.selectedSignUpAs == 'culinarySchool'
                              ? kcwhitecolor
                              : kcPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => viewModel.handleSignUpAs(0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: viewModel.selectedSignUpAs == 'guest'
                        ? kcPrimaryColor
                        : kcwhitecolor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: SvgPicture.asset(
                          'assets/images/icons/guest.svg',
                          color: viewModel.selectedSignUpAs == 'guest'
                              ? kcwhitecolor
                              : kcPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Guest',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: viewModel.selectedSignUpAs == 'guest'
                              ? kcwhitecolor
                              : kcPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  RoleDialogDialogModel viewModelBuilder(BuildContext context) =>
      RoleDialogDialogModel();
}
