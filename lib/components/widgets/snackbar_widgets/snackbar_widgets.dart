import 'package:flutter/material.dart';

SnackBar snackBarWhenFailure({required String snackBarFailureText}) {
  return SnackBar(
    content: Text(snackBarFailureText),
    backgroundColor: Colors.red,
  );
}

SnackBar snackBarWhenSuccess(snackBarFailureText) {
  return SnackBar(
    content: Text(snackBarFailureText),
    backgroundColor: Colors.green,
  );
}
