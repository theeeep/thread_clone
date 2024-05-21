import 'package:flutter/material.dart';

ButtonStyle customOutlineBtnStyle() {
  return ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
