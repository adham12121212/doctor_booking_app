
import 'package:booked_app/core/constants/app_colors.dart';
import 'package:booked_app/feature/auth/login/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key, required this.controller,
  });
   final TextEditingController controller;
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {

   bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      hintText: 'Password',
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.blueColor,
        ),
        onPressed: () {
          // Toggle password visibility
          setState(() {
            obscureText = !obscureText;
            });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 8) {
          return ' must be at least 8 characters ';
        }
        if (!RegExp(r'[A-Z]').hasMatch(value)) {
          return ' must contain  uppercase letter';
        }
        if (!RegExp(r'[a-z]').hasMatch(value)) {
          return ' must contain  lowercase letter';
        }
        if (!RegExp(r'[0-9]').hasMatch(value)) {
          return ' must contain  one number';
        }
        if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
          return 'must contain  special character';
        }
        return null;
      },
    );
  }
}
