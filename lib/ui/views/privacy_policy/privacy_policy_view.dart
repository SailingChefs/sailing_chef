import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'privacy_policy_viewmodel.dart';

class PrivacyPolicyView extends StackedView<PrivacyPolicyViewModel> {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PrivacyPolicyViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          title: Text( 'Terms and Conditions',style: globalTextStyle(fontSize: 18.0 ,color: kcBlackColor),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child:Text(
              textAlign: TextAlign.justify,
              style: globalTextStyle(fontSize: 16.0 ,color: kcBlackColor,fontWeight: FontWeight.w400),
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac nunc vel nulla commodo tincidunt. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Maecenas tincidunt justo sit amet magna tempus, at rutrum purus sollicitudin. Nulla facilisi. Vivamus eu eros ut nisl sollicitudin tristique. Integer ac odio ac est convallis tempor ac vel velit. Vivamus a mi nec velit porta pulvinar nec non felis. Duis auctor nunc nec dui pretium, ut convallis velit finibus. Sed at justo quis tortor laoreet egestas. Vivamus euismod eros nec erat tristique, sit amet blandit ante sollicitudin. Phasellus ac nisi id odio convallis condimentum nec a tellus. Vivamus malesuada lacus vel urna tempor, id efficitur eros volutpat. Suspendisse vel tristique justo. Vivamus finibus mauris in felis feugiat fringilla. Phasellus nec nibh vel ex consequat fermentum.\n\n\nPellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin lobortis semper semper. Nam vitae libero mauris. Proin sed ipsum eu nunc ullamcorper ultricies. Fusce quis nisi a mauris efficitur convallis. Ut dignissim felis at tortor eleifend, id fringilla nisi vestibulum. Vivamus bibendum orci eget sapien venenatis, at pharetra lacus sollicitudin. Etiam mattis odio sit amet mauris gravida faucibus. Integer sed feugiat orci. Curabitur auctor, tortor sit amet tempus feugiat, velit mauris laoreet lorem, nec tincidunt odio nulla ac metus. Donec eu tincidunt justo. Sed varius, leo ac congue luctus, purus lacus suscipit mi, ac accumsan purus ligula nec nunc. Sed nec scelerisque justo. Phasellus sodales sit amet libero eu sollicitudin. Cras euismod arcu in nunc convallis, sit amet feugiat turpis fermentum.'
            ),
          ),
        ),
      ),
    );
  }

  @override
  PrivacyPolicyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PrivacyPolicyViewModel();
}
