import 'package:sailing_chefs/core/helpers/capitalize_first_fucntion.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';
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
    if (query.trim().isEmpty) {
      return _buildEmptyState();
    }

    return FutureBuilder<List<PinnedLocation>>(
      future: _searchService.filterPinnedLocations(query.trim()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (snapshot.hasError) {
          return _buildErrorState();
        }

        final pins = snapshot.data;

        if (pins == null || pins.isEmpty) {
          return _buildNoResultsState(context);
        }

        return _buildResultsList(pins);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Search for businesses, restaurants, or services',
            style: globalTextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching for "bakery", "restaurant", or "market"',
            style: globalTextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Searching...'),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Search Error',
            style: globalTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.red[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Unable to search at this time. Please try again.',
            style: globalTextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Results Found',
            style: globalTextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try different keywords or check spelling',
            style: globalTextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Search suggestions:',
            style: globalTextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: ['Restaurant', 'Bakery', 'Market', 'Provisioner']
                .map((suggestion) => ActionChip(
                      label: Text(
                        suggestion,
                        style: globalTextStyle(
                          fontSize: 12,
                          color: kcPrimaryColor,
                        ),
                      ),
                      onPressed: () {
                        query = suggestion;
                        showResults(context);
                      },
                      backgroundColor: kcPrimaryColor.withOpacity(0.1),
                      side: BorderSide(color: kcPrimaryColor.withOpacity(0.3)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList(List<PinnedLocation> pins) {
    return Column(
      children: [
        _buildResultsHeader(pins.length),
        Expanded(
          child: ListView.builder(
            itemCount: pins.length,
            itemBuilder: (context, index) =>
                _buildResultItem(context, pins[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsHeader(int resultCount) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: kcPrimaryColor, size: 20),
          const SizedBox(width: 8),
          Text(
            '$resultCount result${resultCount == 1 ? '' : 's'} found',
            style: globalTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(BuildContext context, PinnedLocation pin) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: _buildResultItemImage(pin),
          title: _buildResultItemTitle(pin),
          subtitle: _buildResultItemSubtitle(pin),
          trailing: _buildResultItemRating(pin),
          onTap: () {
            close(context, [pin]);
          },
        ),
        _buildResultItemDivider(),
      ],
    );
  }

  Widget _buildResultItemImage(PinnedLocation pin) {
    // Only use a valid image URL, otherwise fallback to asset
    final String? imageUrl =
        (pin.picture.isNotEmpty && pin.picture.first.isNotEmpty)
            ? pin.picture.first
            : null;
    return Container(
      height: 50.h,
      width: 50.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      // Use clip rect with decoration to ensure proper border radius
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ImageUtils.networkImageWithFallback(
          imageUrl: imageUrl,
          width: 50.w,
          height: 50.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildResultItemTitle(PinnedLocation pin) {
    return Text(
      capitalizeEachWord(pin.name),
      style: globalTextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: kcBlackColor,
      ),
    );
  }

  Widget _buildResultItemSubtitle(PinnedLocation pin) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (pin.tags.isNotEmpty) ...[
          Text(
            pin.tags.take(3).join(' • '),
            style: globalTextStyle(
              fontSize: 12,
              color: kcPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
        ],
        Text(
          pin.description.isNotEmpty ? pin.description : pin.place,
          style: globalTextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildResultItemRating(PinnedLocation pin) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: kclightgreencolor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 14,
            color: kclightgreencolor,
          ),
          const SizedBox(width: 4),
          Text(
            pin.rating.toStringAsFixed(1),
            style: globalTextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: kclightgreencolor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultItemDivider() {
    return Divider(
      color: Colors.grey[200],
      thickness: 1,
      height: 1,
      indent: 82,
      endIndent: 16,
    );
  }
}
