import 'dart:developer';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class ChefsNote extends ViewModelWidget<AddRecipeViewModel> {
  const ChefsNote({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    log('Rebuild');
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
            left: 10.dg,
          ),
          decoration: BoxDecoration(
            color: kcVeryLightGrey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: viewModel.shouldShowHint
                    ? Text(
                        'Add tips for this recipe',
                        style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor.withOpacity(0.5)),
                      )
                    : viewModel.hasRecordedAudio &&
                            !viewModel.isRecording
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: viewModel.startListening,
                                icon: const Icon(
                                  Icons.play_arrow,
                                  color: kcPrimaryColorDark,
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: AudioFileWaveforms(
                                    enableSeekGesture: false,
                                    size: const Size(
                                        double.maxFinite, double.maxFinite),
                                    playerController:
                                        viewModel.playerController,
                                    waveformData: viewModel.waveFormData!,
                                    playerWaveStyle: const PlayerWaveStyle(
                                      fixedWaveColor: Colors.black,
                                      liveWaveColor: kcPrimaryColor,
                                      spacing: 6,
                                      seekLineColor: Colors.black,
                                      showSeekLine: false,

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : AudioWaveforms(
                            size: const Size(double.maxFinite, 50),
                            recorderController: viewModel.recorderController,
                            enableGesture: true,
                            waveStyle: const WaveStyle(
                              waveColor: Colors.black,
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
              Visibility(
                visible: viewModel
                        .hasRecordedAudio,
                child: GestureDetector(
                  onTap: () {
                    viewModel.deleteCurrentRecording();
                  },
                  child: const Icon(
                    Icons.delete,
                    color: kcPrimaryColorDark,
                  ),
                ),
              ),
              Visibility(
                visible: !viewModel
                        .hasRecordedAudio,
                child: GestureDetector(
                  onLongPressStart: (_) => viewModel.startRecording(),
                  onLongPressEnd: (_) => viewModel.stopRecording(),
                  child: const Icon(
                    Icons.mic,
                    color: kcPrimaryColorDark,
                  ),
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
