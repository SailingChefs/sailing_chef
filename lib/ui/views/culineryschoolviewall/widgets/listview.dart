
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/culineryschoolviewall_viewmodel.dart';

class ListViewCulinaryChool
    extends ViewModelWidget<CulineryschoolviewallViewModel> {
  const ListViewCulinaryChool({super.key});

  @override
  Widget build(BuildContext context, CulineryschoolviewallViewModel viewModel) {
    return Column(
      children: [
        verticalSpaceMedium,
        Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: viewModel.cullinary.length,
            itemBuilder: (BuildContext context, int index) {

              return GestureDetector(
                onTap: () =>
                    viewModel.toUserDetails(viewModel.cullinary[index]),
                child: Container(
                  height: 113.h,
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: kcWhiteColor.withOpacity(0.97),
                    boxShadow: [
                      BoxShadow(
                        color: kcBlackColor.withOpacity(0.09),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 113.h,
                        width: 113.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: viewModel
                                  .cullinary[index].displayPicture!.isEmpty
                              ? const Icon(Icons.person)
                              : Image.network(
                                  viewModel.cullinary[index].displayPicture!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: FittedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                viewModel.cullinary[index].displayName!,
                                style: globalTextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700,
                                  color: kcBlackColor,
                                ),
                              ),
                               viewModel.cullinary[index].namedLocation != null
                                  ? Column(
                                      children: [
                                        verticalSpace(5),
                                        Text(
                                           viewModel.cullinary[index].namedLocation!,
                                          style: globalTextStyle(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.w500,
                                            color: kcBlackColor,
                                          ),
                                        ),
                                        verticalSpace(5),
                                      ],
                                    )
                                  : const SizedBox(),
                              Text(
                                '${viewModel.cullinary[index].schoolCourses!.length} Courses',
                                style: globalTextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: kcBlackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
