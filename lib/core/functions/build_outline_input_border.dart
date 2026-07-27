import 'package:flutter/material.dart';

OutlineInputBorder buildOutlineInputBorder(Color borderColor) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: borderColor),
  );
}
