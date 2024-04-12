import 'package:fluttertoast/fluttertoast.dart';

class ShowToastComponent {
  static void showToastSuccess(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
