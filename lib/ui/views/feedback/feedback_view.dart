import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/global_uservariable.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/feedback/feedback_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/primarycolor_rounded_elevated_button.dart';
import 'package:sailing_chefs/ui/widgets/semi_rounded_textfield.dart';

class FeedbackView extends StackedView<FeedbackViewModel> {
  const FeedbackView({super.key});

  @override
  Widget builder(
    BuildContext context,
    FeedbackViewModel viewModel,
    Widget? child,
  ) {
    final userId = userDetails!.uid;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => viewModel.getBack(),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 8.0.dg),
            height: 36.h,
            width: 36.w,
            child: Icon(
              Icons.arrow_back_ios,
              color: kcBlackColor,
              size: 18.sp,
            ),
          ),
        ),
        title: Text('Send Feedback',
            style: globalTextStyle(color: kcBlackColor, fontSize: 16)),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SemiRoundedTranpaentTextField(
              inputFormatters: [LengthLimitingTextInputFormatter(200)],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter feedback';
                }
                return null;
              },
              maxLines: 5,
              suffixIcon: false,
              fillColor: kcPrimaryColor.withOpacity(0.09),
              controller: viewModel.feedbackController,
              labelText: 'Feedback',
            ),
            verticalSpaceMedium,
            PrimaryColorRoundedElevatedButton(
              200.w,
              onPressed: () async {
                await viewModel.submitFeedback(userId!);
              },
              buttonText: 'Send Feedback',
            ),
          ],
        ),
      ),
    );
  }

  @override
  FeedbackViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FeedbackViewModel();
}
