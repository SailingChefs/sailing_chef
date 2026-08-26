import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/shimmer_container.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoaderChatList extends ViewModelWidget<ChatListViewModel> {
  const ShimmerLoaderChatList({super.key});

  @override
  Widget build(BuildContext context, ChatListViewModel viewModel) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(5),
                    leading: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: CircleAvatar(
                          radius: 30.r,
                        )),
                    title: const ShimmerContainer(
                      height: 25,
                      width: 80,
                    ),
                    subtitle: const ShimmerContainer(
                      height: 20,
                      width: 45,
                    ),
                    trailing: const ShimmerContainer(
                      height: 20,
                      width: 35,
                    ),
                  ),
                  const Divider(
                    color: kcVeryLightGrey,
                    thickness: 0.5,
                  ),
                ],
              );
            });
  }
}
