import 'package:flutter/material.dart';
import 'package:sailing_chefs/ui/common/ui_helpers.dart';

class TestClass extends StatefulWidget {
  const TestClass({super.key});

  @override
  State<TestClass> createState() => _TestClassState();
}

class _TestClassState extends State<TestClass> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet: Container(
        color: Colors.grey.withOpacity(0.5),
        height: 64,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Type message ...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ),
              ),
              horizontalSpaceSmall,
              CircleAvatar(radius: 20,child: Center(child: IconButton(onPressed: (){},icon: Icon(Icons.send),),),)
            ],
          ),
        ),
      ),
        body: SizedBox(
          height: size.height * 0.9,
          child: Stack(
                children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                leadingWidth: 80,
                backgroundColor: Colors.transparent,

                // collapsedHeight: 400,
                flexibleSpace: const FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(
                            'https://imgv3.fotor.com/images/gallery/cartoon-character-generated-by-Fotor-ai-art-creator.jpg'),
                      ),
                      Text(
                        "Someones's Moon",
                        style: TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),

                expandedHeight: 400,

                // flexibleSpace:
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                SizedBox(
                  child: Column(
                    children: [
                      for (int i = 0; i < 100; i++)
                        Text(
                          i.toString(),
                          style: TextStyle(fontSize: 20),
                        )
                    ],
                  ),
                )
              ]))
            ],
          ),

               Positioned(
                 top: 48,
                 left: 16,
                 child: CircleAvatar(
                 radius: 20,
                 child: IconButton(
                   onPressed: () {},
                   icon: Icon(
                     Icons.arrow_back_ios_new,
                     size: 18,
                     color: Colors.black,
                   ),
                 ),
               ),)

                ],
              ),
        ));
  }
}
