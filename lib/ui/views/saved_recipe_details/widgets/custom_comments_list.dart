import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';

class CustomListTileComments extends StatelessWidget {
  final String name;
  final Timestamp date;
  final String description;
  final String image;
  final List<String> ratingImages;
  final double rating;

  const CustomListTileComments({
    super.key,
    required this.name,
    required this.rating,
    required this.date,
    required this.ratingImages,
    required this.description,
    required this.image,
  });
  void openImagePreview(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: PhotoViewGallery.builder(
          itemCount: ratingImages.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(ratingImages[index]),
              minScale: PhotoViewComputedScale.contained * 0.6,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          pageController: PageController(initialPage: initialIndex),
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          gaplessPlayback: false,
          loadingBuilder: (context, progress) => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(date.toDate());
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
          title: Text(
            name,
            style: globalTextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              letterSpacing: -0.5,
              fontWeight: FontWeight.w500,
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
              ratingImages.isNotEmpty
                  ? SizedBox(
                      height: 100.h,
                      child: Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ratingImages.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => openImagePreview(context, index),
                              child: SizedBox(
                                width: 100.w,
                                height: 100.h,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      ratingImages[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          trailing: RatingBarIndicator(
            rating: rating,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
          ),
        ),
        Divider(
          color: Colors.grey.withOpacity(0.2),
          height: 0,
        ),
      ],
    );

    // return Column(
    //   children: [
    //     verticalSpaceSmall,
    //     IntrinsicHeight(
    //       child: SizedBox(
    //         width: MediaQuery.of(context).size.width,
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             CircleAvatar(
    //               backgroundImage: NetworkImage(image),
    //             ),

    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       name,
    //                       style: globalTextStyle(
    //                         color: Colors.black,
    //                         fontSize: 16.sp,
    //                         letterSpacing: -0.5,
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),
    //                     RatingBarIndicator(
    //                       rating: rating,
    //                       itemBuilder: (context, index) => const Icon(
    //                         Icons.star,
    //                         color: Colors.amber,
    //                       ),
    //                       itemCount: 5,
    //                       itemSize: 20.0,
    //                     ),
    //                   ],
    //                 ),
    //                 Text(
    //                   formattedDate,
    //                   style: globalTextStyle(
    //                     color: Colors.grey,
    //                     fontSize: 11.sp,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   width: MediaQuery.of(context).size.width * 0.6.w,
    //                   child: Text(
    //                     description,
    //                     maxLines: 3,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: globalTextStyle(
    //                       letterSpacing: -0.1,
    //                       fontSize: 13.sp,
    //                       fontWeight: FontWeight.w500,
    //                       color: kcBlackColor.withOpacity(0.6),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     verticalSpaceSmall,
    //     ratingImages.isNotEmpty
    //         ? SizedBox(
    //             height: 100.h,
    //             child: Expanded(
    //               child: ListView.builder(
    //                 scrollDirection: Axis.horizontal,
    //                 itemCount: ratingImages.length,
    //                 itemBuilder: (context, index) {
    //                   return GestureDetector(
    //                     onTap: () => openImagePreview(context, index),
    //                     child: SizedBox(
    //                       width: 100.w,
    //                       height: 100.h,
    //                       child: Padding(
    //                         padding: const EdgeInsets.all(8.0),
    //                         child: ClipRRect(
    //                           borderRadius: BorderRadius.circular(10),
    //                           child: Image.network(
    //                             ratingImages[index],
    //                             fit: BoxFit.cover,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //           )
    //         : const SizedBox(),
    //     Divider(
    //       color: Colors.grey.withOpacity(0.2),
    //     ),
    //   ],
    // );
  }
}
