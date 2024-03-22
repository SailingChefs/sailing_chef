// ignore_for_file: depend_on_referenced_packages
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/filter/filter_viewmodel.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

class TimeSliderFilterScreen extends ViewModelWidget<FilterViewModel> {
  const TimeSliderFilterScreen({super.key});

  @override
  Widget build(BuildContext context, FilterViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time',
          style: globalTextStyle(
              fontSize: 20.0.dg,
              color: kcBlackColor,
              fontWeight: FontWeight.w500),
        ),
        verticalSpaceMedium,
        SfRangeSliderTheme(
          data: SfRangeSliderThemeData(
            tooltipBackgroundColor: Colors.transparent,
            tooltipTextStyle:
                globalTextStyle(fontSize: 12.sp, color: kcPrimaryColorDark),
          ),
          child: SfRangeSlider(
            min: 0.0,
            max: 24.0,
            values: viewModel.values,
            showLabels: false,
            interval: 8,
            showTicks: false,
            stepSize: 1,
            activeColor: kcPrimaryColorDark,
            shouldAlwaysShowTooltip: true,
            tooltipTextFormatterCallback: (value, text) {
              return "$text hrs";
            },
            dateIntervalType: DateIntervalType.hours,
            dateFormat: DateFormat.H(),
            enableTooltip: true,
            tooltipShape: const SfPaddleTooltipShape(),
            minorTicksPerInterval: 1,
            labelFormatterCallback: (actualValue, formattedText) =>
                formattedText,
            onChanged: (value) => viewModel.updateValue(value),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '0 Hrs',
            style: globalTextStyle(
                fontSize: 12.sp, color: kcBlackColor.withOpacity(0.2)),
          ),
          Text(
            '8 Hrs',
            style: globalTextStyle(
                fontSize: 12.sp, color: kcBlackColor.withOpacity(0.2)),
          ),
          Text(
            '24+ Hrs',
            style: globalTextStyle(
                fontSize: 12.sp, color: kcBlackColor.withOpacity(0.2)),
          ),
        ]),
      ],
    );
  }
}
