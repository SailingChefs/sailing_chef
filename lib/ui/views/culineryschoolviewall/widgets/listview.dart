import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/culineryschoolviewall_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

class ListViewCulinaryChool
    extends ViewModelWidget<CulineryschoolviewallViewModel> {
  const ListViewCulinaryChool({super.key});

  @override
  Widget build(BuildContext context, CulineryschoolviewallViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Explore Culinary\nSchools',
          style: globalTextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: kcBlackColor),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackArrowWidget(
            onTap: viewModel.toHomeView,
          ),
        ),
      ),
      body: Column(
        children: [
          verticalSpaceMedium,
          ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: viewModel.cullinary.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        // viewModel.toCulinaryDetails(viewModel.cullinary[index]);
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(5),
                        title: Text(
                          viewModel.cullinary[index].displayName!,
                        ),
                        subtitle: Text(
                          viewModel.placemarks!.first.country!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style:
                              TextStyle(color: kcPrimaryColor.withOpacity(0.5)),
                        ),
                        leading: CircleAvatar(
                          radius: 30.r,
                          backgroundImage: NetworkImage(
                              viewModel.cullinary[index].displayPicture!),
                        ),
                      )),
                  const Divider(
                    color: kcVeryLightGrey,
                    thickness: 0.5,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
