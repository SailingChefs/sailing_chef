import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/comments.dart';
import 'package:sailing_chefs/ui/views/saved_recipe_details/widgets/leave_comment_bottom.dart';

class Methods extends StatelessWidget {
  final RecipeModel recipe;
  const Methods({super.key,required this.recipe});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Instructions",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
        
            height: recipe.methods.length * 100.h,
            child: ListView.builder(
              itemCount: recipe.methods.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CircleAvatar(
                          minRadius: double.minPositive + 13,
                          backgroundColor: Colors.blueGrey,
                          child: Text(
                          '${index + 1}',
                            style: const TextStyle(
                                color: kcwhitecolor, fontSize: 12),
                          ),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: 300.w,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                             recipe.methods[index],
                              style: globalTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: kcBlackColor.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          verticalSpaceMedium,
          const Text("Chef Notes",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          verticalSpaceMedium,
          Container(
            height: 48,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: kcMediumGrey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(),
                    backgroundColor: kcPrimaryColor,
                  ),
                  onPressed: () {},
                  child: const Icon(
                    Icons.play_arrow,
                    color: kcwhitecolor,
                  ),
                ),
                horizontalSpaceTiny,
                const Icon(Icons.multitrack_audio, opticalSize: 25),
                const Spacer(),
                const Text("0:05",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                horizontalSpaceTiny,
                Icon(Icons.volume_up,
                    size: 24, color: Colors.black.withOpacity(0.5)),
                horizontalSpaceSmall,
              ],
            ),
          ),
          const CommentsDetailsScreen(),
          const LeaveComment(),
          horizontalSpaceSmall,
        ],
      ),
    );
  }
}
