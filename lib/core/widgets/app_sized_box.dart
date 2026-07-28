import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSizedBox extends StatelessWidget {
  const AppSizedBox({super.key, this.height, this.width, this.child});

  final double? height;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height?.h, width: width?.w, child: child);
  }
}
