import 'package:flutter/material.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/widgets/back_arrow.dart';
import 'package:stacked/stacked.dart';
import 'recipe_list_page_viewmodel.dart';

class RecipeListPageView extends StackedView<RecipeListPageViewModel> {
  const RecipeListPageView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RecipeListPageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BackArrowWidget(
              onTap: () {
                viewModel.popBack();
              },
            ),
          ),
          title: Text(
            'Recipes',
            style: globalTextStyle(
                fontSize: 25.0.dg,
                color: kcBlackColor,
                fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 335,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 225.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/background/burger.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                            width: 95,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.black54.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: const Row(
                              children: [
                                Icon(
                                  FlutterRemix.time_line,
                                  size: 16,
                                  color: kcWhiteColor,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '20 mins',
                                  style: TextStyle(
                                      fontSize: 12.0, color: kcWhiteColor),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpaceSmall,
                        Text(
                          'Shiitaki Mushroom',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                                bottomLeft: Radius.circular(50.0),
                                bottomRight: Radius.circular(50.0),
                              ),
                              child: Image.asset(
                                'assets/images/icons/chef.jpg',
                                width: 35,
                                height: 35,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Danica Nel',
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: kcBlackColor.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 3,
        ));
  }

  @override
  RecipeListPageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      RecipeListPageViewModel();
}
