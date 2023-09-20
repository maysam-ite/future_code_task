import 'package:get/get.dart';

import '../../constant/theme.dart';

SnackbarController snackBarForErrors(String title,String message) {
    return Get.snackbar(
      title.tr, ///// adding for translate  done
      message.tr, //// adding for translate  done
      snackPosition: SnackPosition.TOP,
      colorText: PublicColors().labelColor,
      backgroundColor: PublicColors().labelColor,
      duration: const Duration(seconds: 5),
    );
  }