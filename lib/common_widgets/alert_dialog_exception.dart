import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ctrl/common_widgets/alert_dialog.dart';

Future<void> alertDialogException(
  BuildContext context, {
  required String title,
  required Exception exception,
}) =>
    alertDialog(
      context,
      title: title,
      content: _message(exception),
    );

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message ?? 'no message';
  }
  return exception.toString();
}
