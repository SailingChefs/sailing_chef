import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';

class ChefsNote extends ViewModelWidget<AddRecipeViewModel> {
  const ChefsNote(this.drafts, {super.key});
  final RecipeModel? drafts;
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
        (drafts?.chefNote.isNotEmpty ?? false) &&
                (drafts?.waveForm.isNotEmpty ?? false)
            ? Container(
                height: 48,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kcMediumGrey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
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
                          width: screenWidth(context) * 0.56,
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.volume_up,
                            ))
                      ],
                    ),
                  ],
                ),
              )
            : Container(
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
                          : (drafts?.waveForm.isNotEmpty ?? false)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
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
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: AudioFileWaveforms(
                                          enableSeekGesture: false,
                                          size: const Size(double.maxFinite,
                                              double.maxFinite),
                                          playerController:
                                              viewModel.playerController,
                                          waveformData: viewModel.waveFormData!,
                                          playerWaveStyle:
                                              const PlayerWaveStyle(
                                            fixedWaveColor: Colors.black,
                                            liveWaveColor: kcPrimaryColor,
                                            spacing: 6,
                                            seekLineColor: Colors.black,
                                            showSeekLine: false,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : viewModel.hasRecordedAudio &&
                                      !viewModel.isRecording
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          width: screenWidth(context) * 0.58,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: AudioFileWaveforms(
                                              waveformType:
                                                  WaveformType.fitWidth,
                                              enableSeekGesture: false,
                                              size: const Size(double.maxFinite,
                                                  double.maxFinite),
                                              playerController:
                                                  viewModel.playerController,
                                              waveformData:
                                                  viewModel.waveFormData!,
                                              playerWaveStyle:
                                                  const PlayerWaveStyle(
                                                fixedWaveColor: Colors.black,
                                                liveWaveColor: kcPrimaryColor,
                                                spacing: 8,
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
                                      recorderController:
                                          viewModel.recorderController,
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
                      visible: viewModel.hasRecordedAudio,
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
                      visible: !viewModel.hasRecordedAudio,
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
