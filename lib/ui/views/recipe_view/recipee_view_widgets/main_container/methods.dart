// ignore_for_file: prefer_const_constructors

import 'package:sailing_chefs/core/imports/core_imports.dart';

import '../../../../widgets/bottom_sheet_btn.dart';

class Methods extends StatelessWidget {
  const Methods({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> steps = ['1', '2', '3', '4', '5'];

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
            width: 400,
            height: 500,
            child: ListView.builder(
              itemCount: steps.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
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
                            steps[index],
                            style: TextStyle(color: kcwhitecolor, fontSize: 12),
                          ),
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: 300.w,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your',
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
                  child: Icon(
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
          verticalSpaceLarge,
          Save_Recipe_Button(
            onPressed: () {},
            buttonText: 'Submit Recipe',
          ),
          horizontalSpaceSmall,
        ],
      ),
    );
  }
}
