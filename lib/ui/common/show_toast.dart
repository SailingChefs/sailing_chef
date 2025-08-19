import 'package:flutter_easyloading/flutter_easyloading.dart';

void showToast({
  required String message,
}) =>
    EasyLoading.showToast(
      message,
      duration: const Duration(seconds: 3),
      toastPosition: EasyLoadingToastPosition.top,
      maskType: EasyLoadingMaskType.black,
    );
