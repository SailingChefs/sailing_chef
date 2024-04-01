import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class ChefsNote extends ViewModelWidget<AddRecipeViewModel> {
  const ChefsNote({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chef\'s Note',
          style: globalTextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: kcBlackColor),
        ),
        verticalSpaceTiny,
        GestureDetector(
          onTap: viewModel.callIngredientsBottomSheet,
          child: Container(
            height: 50.h,
            padding: EdgeInsets.only(
              left: 20.dg,
            ),
            decoration: BoxDecoration(
              color: kcVeryLightGrey.withOpacity(0.2),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !viewModel.recorderController.recorderState.isInitialized
                    ? Text(
                        'Add tips for this recipe',
                        style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor.withOpacity(0.5)),
                      )
                    : AudioWaveforms(
                        size: Size(MediaQuery.of(context).size.width, 200.0),
                        recorderController: viewModel.recorderController,
                        enableGesture: true,
                        waveStyle: const WaveStyle(
                          waveColor: kcPrimaryColorDark,
                          showDurationLabel: true,
                          spacing: 8.0,
                          showBottom: false,
                          extendWaveform: true,
                          showMiddleLine: false,

                          //   gradient: LinearGradient(
                          //     colors: [Colors.red, Colors.green],
                          // ),
                        ),
                      ),
                IconButton(
                  onPressed: () => viewModel.recordAudio(),
                  icon: const Icon(
                    Icons.mic,
                    color: kcPrimaryColorDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
