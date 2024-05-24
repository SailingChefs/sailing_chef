import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/sign_up/sign_up_viewmodel.dart';

class RoleSelector extends ViewModelWidget<SignUpViewModel> {

  const RoleSelector({super.key});

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return Container(
      height: screenHeight(context) * 0.08,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F8F7).withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
           Expanded(
            child: GestureDetector(
              onTap: () => viewModel.handleSignUpAs(2),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                 
                  ),
                  color: viewModel.selectedSignUpAs == 'chef'
                      ? kcPrimaryColor
                      : Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icons/chef.png',
                    ),
                    verticalSpaceTiny,
                    const Text(
                      'Chef',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kcWhiteColor,
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
                      : Colors.transparent,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school_rounded,
                      color: kcWhiteColor,
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Culinary school',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kcWhiteColor,
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
                      
                      : Colors.transparent,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: kcWhiteColor,
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Guest',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kcWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}
