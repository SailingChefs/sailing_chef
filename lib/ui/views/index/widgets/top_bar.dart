import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/index/index_viewmodel.dart';

class TopBarIndexScreen extends ViewModelWidget<IndexViewModel> implements PreferredSizeWidget{
  const TopBarIndexScreen({super.key});

  @override
  Widget build(BuildContext context, IndexViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          Image.asset(
            'assets/images/logo/SAILING CHEFS2.png',
            width: 170.w,
            height: 70.h,
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
