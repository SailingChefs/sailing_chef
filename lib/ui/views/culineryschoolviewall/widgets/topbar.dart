import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/culineryschoolviewall_viewmodel.dart';
import 'package:sailing_chefs/ui/views/culineryschoolviewall/widgets/listview.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';

class TopBarCullinarySchool
    extends ViewModelWidget<CulineryschoolviewallViewModel> {
  const TopBarCullinarySchool({super.key});

  @override
  Widget build(BuildContext context, CulineryschoolviewallViewModel viewModel) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          title: Text(
            'Meet Your Chefs',
            style: globalTextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: kcBlackColor),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BackArrowWidget(
              onTap: viewModel.toHomeView,
            ),
          )),
      body: const ListViewCulinaryChool(),
    );
  }
}
