// ignore_for_file: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/filter/filter_viewmodel.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

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
                globalTextStyle(fontSize: 12.sp, color: kcPrimaryColor),
          ),
          child: SfRangeSlider(
            onChangeEnd: (value) {
              viewModel.addTimeFilter();
            },
            max: 12.0,
            values: viewModel.values,
            interval: 6,
            stepSize: 1,
            activeColor: kcPrimaryColor,
            shouldAlwaysShowTooltip: true,
            tooltipTextFormatterCallback: (value, text) {
              if ((viewModel.values.end - viewModel.values.start) > 1) {
                if (value == 0 || value == 1) {
                  return '$text hr';
                }
                return '$text hrs';
              }
              return text;
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
            '6 Hrs',
            style: globalTextStyle(
                fontSize: 12.sp, color: kcBlackColor.withOpacity(0.2)),
          ),
          Text(
            '12+ Hrs',
            style: globalTextStyle(
                fontSize: 12.sp, color: kcBlackColor.withOpacity(0.2)),
          ),
        ]),
      ],
    );
  }
}
