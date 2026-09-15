import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/core/utils/image_utils.dart';

class CustomListTileComments extends StatelessWidget {
  final String name;
  final Timestamp date;
  final String description;
  final String image;
  final List<String> ratingImages;
  final double rating;
  final bool isUserComment;
  final Function()? onEdit;
  final Function()? onDelete;

  const CustomListTileComments({
    required this.name,
    required this.rating,
    required this.date,
    required this.ratingImages,
    required this.description,
    required this.image,
    super.key,
    this.isUserComment = false,
    this.onEdit,
    this.onDelete,
  });
  void openImagePreview(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: PhotoViewGallery.builder(
          itemCount: ratingImages.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: ImageUtils.safeNetworkImage(
                ratingImages[index],
              ),
              minScale: PhotoViewComputedScale.contained * 0.6,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          pageController: PageController(initialPage: initialIndex),
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          loadingBuilder: (context, progress) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  // Show confirmation dialog before deletion
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Review',
          style: globalTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: kcBlackColor,
          ),
        ),
        content: Text(
          'Are you sure you want to delete your review?',
          style: globalTextStyle(
            fontSize: 14.sp,
            color: kcBlackColor.withOpacity(0.7),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: globalTextStyle(
                fontSize: 14.sp,
                color: kcBlackColor.withOpacity(0.7),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onDelete != null) onDelete!();
            },
            child: Text(
              'Delete',
              style: globalTextStyle(
                fontSize: 14.sp,
                color: kcErrorColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // dd-MM-yyyy read the same on every device regardless of locale -- a
  // US reader expecting MM/dd/yyyy would misread it. DateFormat.yMd()
  // renders the device's own locale-appropriate field order instead. It
  // needs that locale's data preloaded via initializeDateFormatting(),
  // which isn't set up app-wide, so fall back to the original fixed
  // format rather than crash for a locale that isn't initialized -- the
  // exact locales this fix is meant to help.
  String _formatDate(BuildContext context, Timestamp timestamp) {
    final locale = Localizations.maybeLocaleOf(context)?.toString();
    try {
      return DateFormat.yMd(locale).format(timestamp.toDate());
    } catch (_) {
      return DateFormat('dd-MM-yyyy').format(timestamp.toDate());
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDate(context, date);
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: ImageUtils.safeNetworkImageForAvatar(
              image,
            ),
          ),
          title: Text(
            name,
            style: globalTextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              letterSpacing: -0.5,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing: SizedBox(
            width: 90.w, // Increased width to prevent overflow
            height: 48.h, // Fixed height to prevent vertical overflow
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RatingBarIndicator(
                  rating: rating,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: kclightgreencolor,
                  ),
                  itemSize: 15.0, // Made even smaller
                ),
                if (isUserComment)
                  SizedBox(
                    height: 30.h,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 36.w,
                          height: 30.h,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 16.sp,
                              color: kcPrimaryColor,
                            ),
                            onPressed: onEdit != null
                                ? () {
                                    HapticFeedback.mediumImpact();
                                    onEdit!();
                                  }
                                : null,
                            tooltip: 'Edit Review',
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            splashRadius: 20,
                            splashColor: kcPrimaryColor.withOpacity(0.2),
                          ),
                        ),
                        SizedBox(
                          width: 36.w,
                          height: 30.h,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 16.sp,
                              color: kcErrorColor,
                            ),
                            onPressed: onDelete != null
                                ? () {
                                    HapticFeedback.mediumImpact();
                                    _showDeleteConfirmation(context);
                                  }
                                : null,
                            tooltip: 'Delete Review',
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            splashRadius: 20,
                            splashColor: kcErrorColor.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: globalTextStyle(
                  color: Colors.grey,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6.w,
                child: Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: globalTextStyle(
                    letterSpacing: -0.1,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: kcBlackColor.withOpacity(0.6),
                  ),
                ),
              ),
              verticalSpaceSmall,
              if (ratingImages.isNotEmpty)
                SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ratingImages.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => openImagePreview(context, index),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: ratingImages[index],
                              height: 84.h,
                              width: 84.w,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) => Container(
                                decoration: const BoxDecoration(
                                  color: kcsgreycolor,
                                ),
                              ),
                              // Without this, a broken/expired image URL
                              // left the loading placeholder above stuck on
                              // screen forever.
                              errorWidget: (context, url, error) => DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: kcsgreycolor,
                                ),
                                child: Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              else
                const SizedBox(),
            ],
          ),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.2),
          height: 0,
        ),
      ],
    );
  }
}
