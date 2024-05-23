
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/recipe_view/recipe_view_viewmodel.dart';
import 'package:sailing_chefs/ui/widgets/shimmer_container.dart';

class ChefNotes extends ViewModelWidget<RecipeViewViewModel> {
  const ChefNotes({super.key});

  @override
  Widget build(BuildContext context, RecipeViewViewModel viewModel) {

    return viewModel.path!.isEmpty ? Container() :
     Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Text("Chef Notes",
             style: globalTextStyle(
            fontSize: 15.0.sp,
            fontWeight: FontWeight.w700,
            color: kcBlackColor,
          ),),
        verticalSpaceSmall,
        
         viewModel.isBusy
              ? const ShimmerContainer(
                height: 48,
                width: double.maxFinite,
              )
              :Container(
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
                          width: screenWidth(context) * 0.50,
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
                        horizontalSpaceTiny,

                        Text(
                         viewModel.formattedDuration.isEmpty ? '0:00' : '${viewModel.formattedDuration} ',
                          style: globalTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: kcBlackColor,
                          ),
                        ),
                        IconButton(
                          onPressed: 
                            viewModel.onVolumeUpIconPressed, 
                          icon: viewModel.isMute
                              ? const Icon(
                                  Icons.volume_off,
                                )
                              : const Icon(
                                  Icons.volume_up,
                                ),

                        ),

                      ],
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
