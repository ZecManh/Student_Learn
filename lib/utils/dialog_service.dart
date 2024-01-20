import 'package:datn/screen/widget/custom_dialog.dart';
import 'package:get/get.dart';

class DiaLogService{
  static void showToastMessage(bool? status, String message) {
    Get.dialog(CustomDialog(isSuccess: status, message: message));
  }
}