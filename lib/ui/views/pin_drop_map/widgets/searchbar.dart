import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/pin_model.dart';
import 'package:sailing_chefs/services/search_service.dart';

class PinsSearchDelegate extends SearchDelegate<List<PinnedLocation>> {
  final SearchService _searchService = SearchService();
  @override
  String get searchFieldLabel => 'Search Pinned Locations';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Type something to search'),
      );
    }

    return FutureBuilder<List<PinnedLocation>>(
      future: _searchService.filterPinnedLocations(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final pins = snapshot.data;

        if (pins == null || pins.isEmpty) {
          return const Center(
            child: Text('No Pinned Locations found'),
          );
        }

        return ListView.builder(
          itemCount: pins.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(pins[index].picture),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(capitalizeEachWord(pins[index].name)),
              // trailing: const Icon(Icons.chevron_right),
              subtitle: Text(pins[index].description),
              // onTap: () {

              // },
            );
          },
        );
      },
    );
  }
}
