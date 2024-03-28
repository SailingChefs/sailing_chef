// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors

import 'package:sailing_chefs/core/imports/core_imports.dart';

class FollowingFollowerList extends StatelessWidget {
  final List<String> names = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Brown',
    'Eve Wilson'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      child: ListView.builder(
        itemCount: names.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(
                names[index][0],
                style: TextStyle(fontSize: 15),
              ),
            ),
            title: Text(names[index]),
            trailing: TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kcPrimaryColor),
              ),
              onPressed: () {},
              child: Text(
                'Following',
                style: TextStyle(color: kcwhitecolor),
              ),
            ),
          );
        },
      ),
    );
  }
}
