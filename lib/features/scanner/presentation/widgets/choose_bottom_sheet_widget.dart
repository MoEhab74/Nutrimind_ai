import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimind_ai/core/services/get_it_sevice.dart';
import 'package:nutrimind_ai/features/scanner/presentation/manager/scan_cubit/scan_cubit.dart';
import 'package:nutrimind_ai/features/scanner/presentation/widgets/choose_card_widget.dart';

class ChooseBottomSheetWidget extends StatelessWidget {
  const ChooseBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // if  ChooseBottomSheetWidget is opened from HomeView, padding will be added in HomeView
    // so check if padding is needed
    final padding =
        (context.findAncestorWidgetOfExactType<BottomNavigationBar>() != null)
        ? EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h)
        : EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h + 28.h);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outline,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 24.h),

          Text(
            "Choose Image Source",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          SizedBox(height: 24.h),

          Row(
            children: [
              Expanded(
                child: ChooseCard(
                  icon: Icons.photo_library_outlined,
                  title: "Gallery",
                  onTap: () async {
                    final scanCubit = context.read<ScanCubit>();
                    Navigator.pop(context);
                    // Pick from gallery
                    final image = await getIt<ImagePicker>().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image == null) return;
                    scanCubit.scanImage(image: image);
                  },
                ),
              ),

              SizedBox(width: 16.w),

              Expanded(
                child: ChooseCard(
                  icon: Icons.photo_camera_outlined,
                  title: "Camera",
                  onTap: () async {
                    final scanCubit = context.read<ScanCubit>();
                    Navigator.pop(context);
                    // Open camera
                    final image = await getIt<ImagePicker>().pickImage(
                      source: ImageSource.camera,
                    );
                    if (image == null) return;
                    scanCubit.scanImage(image: image);
                  },
                ),
              ),
            ],
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
