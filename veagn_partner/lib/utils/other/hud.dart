import 'package:flutter_svprogresshud/svprogresshud.dart';

class ZQHUD {
  static void showErrorTips(String msg, {bool autoDismiss = true}) {
    SVProgressHUD.showError(msg);
    if (autoDismiss) {
      SVProgressHUD.dismissWithDelay(1000);
    }
  }

  static void showInfo(String msg, {bool autoDismiss = true, int delay}) {
    SVProgressHUD.showInfo(msg);
    if (autoDismiss) {
      SVProgressHUD.dismissWithDelay(delay ?? 1000);
    }
  }

  static void showSuccess(String msg, {bool autoDismiss = true, int delay}) {
    SVProgressHUD.showSuccess(msg);
    if (autoDismiss) {
      SVProgressHUD.dismissWithDelay(delay ?? 1000);
    }
  }
}
