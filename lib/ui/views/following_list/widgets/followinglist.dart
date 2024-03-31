// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, prefer_const_constructors

import 'package:sailing_chefs/core/imports/core_imports.dart';

class FollowingFollowerList extends StatelessWidget {
  final List<String> names = [
    'John Doe',
    'Jane Smith',
    'Alice Johnson',
    'Bob Brown',
    'Eve Wilson',
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
              backgroundImage: AssetImage('assets/images/icons/chef.jpg'),
            ),
            title: Text(names[index]),
            trailing: SizedBox(
              width: 109,
              height: 34,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kcPrimaryColor),
                ),
                onPressed: () {},
                child: Text(
                  'Following',
                  style: TextStyle(
                      color: kcwhitecolor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
