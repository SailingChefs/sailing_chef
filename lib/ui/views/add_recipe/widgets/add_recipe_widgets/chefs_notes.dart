import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/model/recipe_model.dart';
import 'package:sailing_chefs/ui/views/add_recipe/add_recipe_viewmodel.dart';
import 'package:sailing_chefs/ui/views/add_recipe/widgets/chefnotes_new.dart';

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
            fontSize: 14.sp,
            letterSpacing: -0.5,
            fontWeight: FontWeight.w600,
            color: kcBlackColor,
          ),
        ),
        verticalSpaceTiny,
        (drafts?.chefNote.isNotEmpty ?? false) &&
                (drafts?.waveForm.isNotEmpty ?? false)
            ? Container(
                height: 48,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kcPrimaryColor.withOpacity(0.07),
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
                          width: screenWidth(context) * 0.47.w,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: AudioFileWaveforms(
                              waveformType: WaveformType.fitWidth,
                              enableSeekGesture: false,
                              size: const Size(
                                  double.maxFinite, double.maxFinite),
                              playerController: viewModel.playerController,
                              waveformData: viewModel.waveFormData == null ? [] : viewModel.waveFormData!,
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
                        horizontalSpaceTiny,
                        Text('${viewModel.formattedDuration} ',
                            style: globalTextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: kcBlackColor,
                            )),
                       viewModel.recipeModel != null 
                       ? viewModel.recipeModel!.chefNote.isNotEmpty
                            ? Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      viewModel.deleteCurrentRecording();
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: kcPrimaryColorDark,
                                    ),
                                  ),
                                  horizontalSpaceSmall,
                                ],
                              )
                            : IconButton(
                                onPressed: () {
                                  viewModel.onVolumeUpIconPressed();
                                },
                                icon: viewModel.isMute
                                    ? const Icon(
                                        Icons.volume_off,
                                      )
                                    : const Icon(
                                        Icons.volume_up,
                                      ),
                              ) : Container(),
                      ],
                    ),
                  ],
                ),
              ) : const ChefsNoteNew()
            
      ],
    );
  }
}
