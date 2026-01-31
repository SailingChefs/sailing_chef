import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/ui/views/manage_pins/manage_pins_viewmodel.dart';
import 'package:sailing_chefs/ui/views/manage_pins/widgets/manage_pins.dart';
import 'package:sailing_chefs/ui/widgets/top_bar_admin_view.dart';

class ManagePinsView extends StackedView<ManagePinsViewModel> {
  const ManagePinsView({super.key});

  @override
  Widget builder(
    BuildContext context,
    ManagePinsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: const TopBarAdminView<ManagePinsViewModel>('Manage Pins'),
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'Pending'),
                  Tab(text: 'Review'),
                  Tab(text: 'Published'),
                ],
                labelColor: Colors.black,
                indicatorColor: Colors.green,
              ),
              Expanded(
                child: StreamBuilder(
                    stream: viewModel.pinsService.getPinsAsStream(),
                    builder: (context, asyncSnapshot) {
                      final pins = asyncSnapshot.data;

                      final pendingPins = pins
                              ?.where((recipe) =>
                                  recipe.status == PinnedLocationStatus.pending)
                              .toList() ??
                          [];
                      final reviewPins = pins
                              ?.where((recipe) =>
                                  recipe.status == PinnedLocationStatus.review)
                              .toList() ??
                          [];
                      final publishedPins = pins
                              ?.where((recipe) =>
                                  recipe.status ==
                                  PinnedLocationStatus.published)
                              .toList() ??
                          [];

                      return TabBarView(
                        children: [
                          ManagePins(
                            viewModel,
                            pendingPins,
                          ),
                          ManagePins(
                            viewModel,
                            reviewPins,
                          ),
                          ManagePins(
                            viewModel,
                            publishedPins,
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ManagePinsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ManagePinsViewModel();
}
