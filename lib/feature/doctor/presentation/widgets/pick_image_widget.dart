import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatefulWidget {
  const PickImageWidget({super.key, required this.onPicked});
  final void Function(XFile file) onPicked;

  @override
  State<PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;

  Future<void> pickImage() async {
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
      maxWidth: 800,
    );
    if (image == null) return;

    setState(() => imageFile = image);
    widget.onPicked(image); // ✅ رجّعها للـ parent
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: pickImage,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white30,
              ),
              child: imageFile != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: Image.file(File(imageFile!.path), fit: BoxFit.cover),
              )
                  : Center(
                child: Icon(Icons.person, color: Colors.white, size: 50.w),
              ),
            ),
            Positioned(
              bottom: -5.h,
              right: 8.w,
              child: IconButton(
                onPressed: pickImage,
                icon: const Icon(Icons.add_a_photo, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
