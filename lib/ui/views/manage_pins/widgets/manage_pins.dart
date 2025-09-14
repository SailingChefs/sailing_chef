import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/ui/common/show_toast.dart';
import 'package:sailing_chefs/ui/views/manage_pins/manage_pins_viewmodel.dart';

class ManagePins extends StatelessWidget {
  const ManagePins(this.viewModel, this.pins, {super.key, this.onTap});

  final ManagePinsViewModel viewModel;
  final List<PinnedLocation> pins;
  final VoidCallback? onTap;

  DismissDirection get _dismissDirection => switch (pins.first.status) {
        PinnedLocationStatus.pending => DismissDirection.horizontal,
        PinnedLocationStatus.review => DismissDirection.startToEnd,
        PinnedLocationStatus.published => DismissDirection.endToStart,
      };

  Future<bool> _handleDismiss(
      BuildContext context, PinnedLocation pin, DismissDirection direction) async {
    try {
      switch (direction) {
        case DismissDirection.startToEnd:
          await viewModel.setPinStatus(pin.id!, PinnedLocationStatus.published);
          showToast(message: '${pin.name} set to Published');
        case DismissDirection.endToStart:
          await viewModel.setPinStatus(pin.id!, PinnedLocationStatus.review);
          showToast(message: '${pin.name} set to Review');
        default:
          return false;
      }
      return true;
    } catch (e) {
      showToast(message: 'Action failed');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pins.length,
      itemBuilder: (context, index) {
        final pin = pins[index];
        return Dismissible(
          key: Key(pin.id!),
          direction: _dismissDirection,
          confirmDismiss: (direction) => _handleDismiss(context, pin, direction),
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 20),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text('Publish',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
                ),
                Icon(Icons.check, color: Colors.white),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.amber,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text('Review',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16)),
                ),
                Icon(Icons.rate_review, color: Colors.black),
              ],
            ),
          ),
          onDismissed: (direction) {
            switch (direction) {
              case DismissDirection.startToEnd:
                viewModel.setPinStatus(pin.id!, PinnedLocationStatus.published);
                showToast(message: '${pin.name} set to Published');
              case DismissDirection.endToStart:
                viewModel.setPinStatus(pin.id!, PinnedLocationStatus.review);
                showToast(message: '${pin.name} set to Review');
              default:
                break;
            }
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            // color: Colors.yellow.withAlpha(200),
            // surfaceTintColor: Colors.red,

            child: ListTile(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                } else {
                  viewModel.toPinDetailsScreen(pin);
                }
              },
              title:
                  Text(pin.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
              subtitle: Text(pin.description),
            ),
          ),
        );
      },
    );
  }
}
