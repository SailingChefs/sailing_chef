// ignore_for_file: depend_on_referenced_packages

import 'package:sailing_chefs/core/imports/core_imports.dart';
import 'package:sailing_chefs/ui/views/filter/filter_viewmodel.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';

class TimeSliderFilterScreen extends ViewModelWidget<FilterViewModel> {
  const TimeSliderFilterScreen({super.key});

  @override
  Widget build(BuildContext context, FilterViewModel viewModel) {
    return Column(
      children: [
        Text(
          'Time',
          style: globalTextStyle(
              fontSize: 20.0.dg,
              color: kcBlackColor,
              fontWeight: FontWeight.w500),
        ),
        SfRangeSlider(
          min: 0,
          max: 24,
          values: viewModel.values,
          interval: 8,
          showTicks: false,
          stepSize: 1,
          activeColor: kcPrimaryColorDark,
          dateIntervalType: DateIntervalType.hours,
          dateFormat: DateFormat.H(),
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          labelFormatterCallback: (actualValue, formattedText) => formattedText,
          onChanged: (value) => viewModel.updateValue(value),
        ),
      ],
    );
  }
}
