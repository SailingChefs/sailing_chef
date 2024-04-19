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
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: kcBlackColor),
        ),
        verticalSpaceTiny,
        Container(
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
              Expanded(
                child: viewModel.recorderController.recordedDuration
                                .inMilliseconds ==
                            0 &&
                        !viewModel.recorderController.isRecording
                    ? Text(
                        'Add tips for this recipe',
                        style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor.withOpacity(0.5)),
                      )
                    : viewModel.recorderController.recordedDuration
                                    .inMilliseconds !=
                                0 &&
                            !viewModel.recorderController.isRecording
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: viewModel.startListening,
                                icon: const Icon(Icons.play_arrow),
                              ),
                              AudioFileWaveforms(
                                size: const Size(double.maxFinite, 100.0),
                                playerController: viewModel.playerController,
                                waveformData: viewModel.waveFormData!,
                                playerWaveStyle: const PlayerWaveStyle(
                                  fixedWaveColor: Colors.white54,
                                  liveWaveColor: Colors.blueAccent,
                                  spacing: 6,
                                ),
                              ),
                            ],
                          )
                        : AudioWaveforms(
                            size: const Size(double.maxFinite, 50),
                            recorderController: viewModel.recorderController,
                            enableGesture: true,
                            waveStyle: const WaveStyle(
                              waveColor: kcPrimaryColorDark,
                              showDurationLabel: false,
                              spacing: 8.0,
                              showBottom: false,
                              extendWaveform: true,
                              showMiddleLine: false,

                              //   gradient: LinearGradient(
                              //     colors: [Colors.red, Colors.green],
                              // ),
                            ),
                          ),
              ),
              GestureDetector(
                onLongPressStart: (_) => viewModel.startRecording(),
                onLongPressEnd: (_) => viewModel.pauseRecording(),
                child: const Icon(
                  Icons.mic,
                  color: kcPrimaryColorDark,
                ),
              ),
              const SizedBox(width: 16)
            ],
          ),
        ),
      ],
    );
  }
}
