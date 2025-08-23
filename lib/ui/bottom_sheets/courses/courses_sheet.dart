import 'package:flutter/services.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/cullinary_cources.dart';
import 'package:sailing_chefs/ui/bottom_sheets/courses/courses_sheet_model.dart';
import 'package:sailing_chefs/ui/bottom_sheets/courses/widgets/buttons.dart';
import 'package:sailing_chefs/ui/bottom_sheets/courses/widgets/link_field.dart';

class CoursesSheet extends StackedView<CoursesSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const CoursesSheet({
    required this.completer,
    required this.request,
    super.key,
  });

  @override
  Widget builder(
    BuildContext context,
    CoursesSheetModel viewModel,
    Widget? child,
  ) {
    Course? course;
    if (request.data != null) {
      course = request.data;
    }

    return viewModel.isBusy
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            decoration: const BoxDecoration(
              color: kcwhitecolor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: viewModel.formKey,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      TextFormField(
                        controller: viewModel.name,
                        style: globalTextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: kcBlackColor.withOpacity(0.6),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter course name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Course Name',
                          border: InputBorder.none,
                          hintStyle: globalTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: kcBlackColor.withOpacity(0.6),
                          ),
                        ),
                      ),
                      Divider(
                        color: kcBlackColor.withOpacity(0.08),
                      ),
                      TextFormField(
                        controller: viewModel.desc,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Basic description',
                          counterText: '',
                          border: InputBorder.none,
                          hintStyle: globalTextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: kcBlackColor.withOpacity(0.4),
                          ),
                        ),
                      ),
                      Divider(
                        color: kcBlackColor.withOpacity(0.08),
                      ),
                      TextFieldLink(
                        hinttext: 'Add link',
                        color: kclightgreencolor.withOpacity(0.8),
                        controller: viewModel.link,
                      ),
                      Divider(
                        color: kcBlackColor.withOpacity(0.08),
                      ),
                      TextFormField(
                        controller: viewModel.numOfDays,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3),
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Number of days';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Number of Days',
                            hintStyle: globalTextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: kcBlackColor.withOpacity(0.4),
                            ),
                            border: InputBorder.none),
                      ),
                      Divider(
                        color: kcBlackColor.withOpacity(0.08),
                      ),
                      verticalSpaceMedium,
                      CoursesButtons(completer: completer),
                      verticalSpaceMedium,
                      if (request.data != null)
                        GestureDetector(
                          onTap: () {
                            completer!(SheetResponse(confirmed: true));
                            viewModel.deleteCourse(course?.id ?? '');
                          },
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Icon(
                              FlutterRemix.delete_bin_6_line,
                              color: kcBlackColor.withOpacity(0.6),
                              size: 20,
                            ),
                            horizontalSpaceSmall,
                            Text(
                              'Delete this course',
                              style: globalTextStyle(
                                  color: kcallertcolor, fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ]),
                        )
                      else
                        Container(),
                      verticalSpaceMedium,
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  @override
  void onViewModelReady(CoursesSheetModel viewModel) {
    viewModel.onViewModelReady(request.data);
    super.onViewModelReady(viewModel);
  }

  @override
  CoursesSheetModel viewModelBuilder(BuildContext context) => CoursesSheetModel(completer);
}
