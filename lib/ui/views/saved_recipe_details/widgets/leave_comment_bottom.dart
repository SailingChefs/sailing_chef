import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/saved_recipe_details_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/rounded_tranparent_textfield.dart';

class LeaveComment extends ViewModelWidget<SavedRecipeDetailsViewModel> {
  final String recipeId;

  const LeaveComment({super.key, required this.recipeId});

  Widget _buildImagePreview(SavedRecipeDetailsViewModel viewModel) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(viewModel.images.length, (index) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(viewModel.images[index]),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            IconButton(
              icon: Icon(Icons.cancel, color: kcTextColor),
              onPressed: () => viewModel.removeImage(index),
            )
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context, SavedRecipeDetailsViewModel viewModel) {
    return Column(
      children: [
        verticalSpaceSmall,
        if (viewModel.images.isNotEmpty) _buildImagePreview(viewModel),
        verticalSpaceSmall,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: viewModel.pickImage,
              child: Icon(
                Icons.camera_alt_outlined,
                color: kcWhiteColor,
                size: 18.sp,
              ),
            ),
            Expanded(
              child: RoundedTransparentTextField(
                borderColor: Colors.black.withOpacity(0.2),
                fillColor: Colors.transparent,
                labelText: 'Leave a comment',
                textColor: Colors.black.withOpacity(0.5),
                controller: viewModel.commentController,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: () => viewModel.addComment(recipeId),
              child: const Icon(
                FlutterRemix.send_plane_line,
                color: kcWhiteColor,
                size: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
