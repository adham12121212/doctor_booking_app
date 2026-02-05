import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_texts.dart';

class AnimatedConfirmButton extends StatefulWidget {
  final Future<void> Function() onPressedAsync;
  final String text;
  final double height ;
  final double width;

  const AnimatedConfirmButton({
    super.key,
    required this.onPressedAsync,
    required this.text,
    this.height =50,
    this.width =200,

  });

  @override
  State<AnimatedConfirmButton> createState() => _AnimatedConfirmButtonState();
}

class _AnimatedConfirmButtonState extends State<AnimatedConfirmButton> {
  double _scale = 1.0;
  bool _isLoading = false;

  void _onTapDown(TapDownDetails details) {
    if (!_isLoading) {
      setState(() {
        _scale = 0.95;
      });
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (!_isLoading) {
      setState(() {
        _scale = 1.0;
      });
    }
  }

  void _onTapCancel() {
    if (!_isLoading) {
      setState(() {
        _scale = 1.0;
      });
    }
  }

  Future<void> _handlePress() async {
    if (_isLoading) return; // منع الضغط المتكرر
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressedAsync();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _scale = 1.0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handlePress,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: AppColors.blueColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0, 5),
                blurRadius: 10,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: _isLoading
              ? SizedBox(
            width: 24.w,
            height: 24.w,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            ),
          )
              : Text(
            widget.text,
            style: AppTextStyles.semiBold16.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
