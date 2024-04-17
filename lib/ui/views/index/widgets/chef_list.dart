import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/custom_textbtn.dart';

class ChefListIndexScreen extends ViewModelWidget<IndexViewModel> {
  const ChefListIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    return  viewModel.chefList!.isEmpty ? Text(
          'No Chef Found',
          style: Theme.of(context).textTheme.titleMedium,
        ) :
     Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Meet your Chef',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            CustomTextButton(
              onPressed: () {},
              buttonText: 'View all',
              textColor: kcTextColor,
            ),
          ],
        ),
        verticalSpaceSmall,
       
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.28.h,
          width: double.maxFinite,
          child: ListView.builder(
            itemCount: viewModel.chefList!.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final chef = viewModel.chefList![index];
              return GestureDetector(
                onTap: (){
                  viewModel.toChefProfile(chef);
                },
                child: Container(
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: kcwhitecolor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                        child: Image.network(
                          chef.displayPicture!,
                          fit: BoxFit.cover,
                          height: 170.h,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(8.0.dg),
                        child: Text(
                          capitalizeEachWord(chef.displayName!),
                          style:  TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
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
