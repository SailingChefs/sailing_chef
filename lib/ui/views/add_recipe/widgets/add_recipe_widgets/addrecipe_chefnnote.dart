import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class AddRecipeChefsNote extends ViewModelWidget<AddRecipeViewModel> {
  const AddRecipeChefsNote({super.key});

  @override
  Widget build(BuildContext context, AddRecipeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50.h,
          padding: EdgeInsets.only(
            left: 10.dg,
          ),
          decoration: BoxDecoration(
            color: kcPrimaryColor.withOpacity(0.07),
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: viewModel.shouldShowHint
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          'Hold to leave a voice note',
                          style: globalTextStyle(
                            fontSize: 12.sp,
                            letterSpacing: -0.5,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor.withOpacity(0.5),
                          ),
                        ),
                      )
                    : viewModel.hasRecordedAudio && !viewModel.isRecording
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: viewModel.isPlaying
                                    ? viewModel.stopListening
                                    : viewModel.startListening,
                                icon: viewModel.isPlaying
                                    ? const Icon(
                                        Icons.stop,
                                        color: kcPrimaryColorDark,
                                      )
                                    : const Icon(
                                        Icons.play_arrow,
                                        color: kcPrimaryColorDark,
                                      ),
                              ),
                              SizedBox(
                                width: screenWidth(context) * 0.5,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: AudioFileWaveforms(
                                    waveformType: WaveformType.fitWidth,
                                    enableSeekGesture: false,
                                    size: const Size(
                                        double.maxFinite, double.maxFinite),
                                    playerController:
                                        viewModel.playerController,
                                    waveformData: viewModel.waveFormData!,
                                    playerWaveStyle: PlayerWaveStyle(
                                      fixedWaveColor:
                                          kcBlackColor.withOpacity(0.5),
                                      liveWaveColor: kcPrimaryColor,
                                      spacing: 8,
                                      seekLineColor:
                                          kcBlackColor.withOpacity(0.5),
                                      showSeekLine: false,
                                    ),
                                  ),
                                ),
                              ),
                              horizontalSpaceTiny,
                              Text('${viewModel.formattedDuration} ',
                                  style: globalTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: kcBlackColor,
                                  )),
                            ],
                          )
                        : AudioWaveforms(
                            size: const Size(double.maxFinite, 50),
                            recorderController: viewModel.recorderController,
                            enableGesture: true,
                            waveStyle: WaveStyle(
                              waveColor: kcBlackColor.withOpacity(0.5),
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
                visible: viewModel.hasRecordedAudio,
                child: GestureDetector(
                  onTap: () {
                    viewModel.deleteaddrecipeCurrentRecording();
                  },
                  child: const Icon(
                    Icons.delete,
                    color: kcPrimaryColorDark,
                  ),
                ),
              ),
              Visibility(
                visible: !viewModel.hasRecordedAudio,
                child: GestureDetector(
                  onLongPressStart: (_) => viewModel.startRecording(),
                  onLongPressEnd: (_) => viewModel.stopRecording(),
                  child: Icon(
                    Icons.mic,
                    color: kcPrimaryColorDark,
                    size: 18.0.dg,
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
