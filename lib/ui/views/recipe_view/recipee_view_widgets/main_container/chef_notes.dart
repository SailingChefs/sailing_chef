import 'dart:developer';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';

class ChefNotes extends ViewModelWidget<RecipeViewViewModel> {
  const ChefNotes({super.key});

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Chef Notes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        verticalSpaceSmall,
        Container(
          height: 48,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: kcMediumGrey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: viewModel.isBusy
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: kcPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: viewModel.isPlaying
                            ? viewModel.stopListening
                            : viewModel.startListening,
                        icon: viewModel.isPlaying
                            ? const Icon(
                                Icons.stop,
                                color: kcWhiteColor,
                              )
                            : const Icon(
                                Icons.play_arrow,
                                color: kcWhiteColor,
                              ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: screenWidth(context) * 0.58,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: AudioFileWaveforms(
                              waveformType: WaveformType.fitWidth,
                              enableSeekGesture: false,
                              size: const Size(
                                  double.maxFinite, double.maxFinite),
                              playerController: viewModel.playerController,
                              waveformData: viewModel.waveFormData!,
                              playerWaveStyle: PlayerWaveStyle(
                                fixedWaveColor: Colors.black,
                                liveWaveColor: kcBlackColor.withOpacity(0.5),
                                spacing: 5,
                                seekLineColor: Colors.black,
                                showSeekLine: false,
                              ),
                            ),
                          ),
                        ),
                        horizontalSpaceSmall,
                        // Text(
                        //   '${viewModel.duration} ',
                        //   style: globalTextStyle(
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w600,
                        //     color: kcBlackColor,
                        //   )
                        // ),
                        IconButton(
                            onPressed: () {
                              log(viewModel.waveFormData!.toString());
                            },
                            icon: const Icon(
                              Icons.volume_up,
                            ))
                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
