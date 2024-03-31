import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/chat_list/chat_list_viewmodel.dart';

class ChatListScreen extends ViewModelWidget<ChatListViewModel> {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, ChatListViewModel viewModel) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: [
            GestureDetector(
              onTap: viewModel.toChatScreen,
              child: const ListTile(
                title: Text("title"),
                subtitle: Text("subtitle"),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/icons/chef.jpg'),
                ),
              ),
            ),
            const Divider(),
          ]);
        });
  }
}
