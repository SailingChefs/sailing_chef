import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/views/admin/admin_viewmodel.dart';
import 'package:sailing_chefs/ui/views/admin/widgets/top_bar_admin_view.dart';
import 'package:stacked/stacked.dart';

class AdminView extends StackedView<AdminViewModel> {
  const AdminView({super.key});

  @override
  Widget builder(
    BuildContext context,
    AdminViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: const TopBarAdminView('Admin'),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'Pending Recipes'),
                  Tab(text: 'Approved Recipes'),
                ],
                labelColor: Colors.black,
                indicatorColor: Colors.green,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    // Replace these with your actual widgets for each tab
                    Center(
                      child: Text(
                        'Tab 1 Content',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Center(
                      child: Text(
                        'Tab 2 Content',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  AdminViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AdminViewModel();
}
