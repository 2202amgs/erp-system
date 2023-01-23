import 'package:flutter/material.dart';
import 'package:frontend/app/core/constants/app_colors.dart';

class InputLoginField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isPassword;
  final String label;
  const InputLoginField(
      {Key? key, this.controller, this.isPassword = false, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      style: TextStyle(color: Theme.of(context).primaryColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).canvasColor,
        labelText: label,
        border: const UnderlineInputBorder(),
        labelStyle: TextStyle(
          color: AppColors.headText,
        ),
        floatingLabelStyle: TextStyle(
          color: AppColors.primary,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.headText,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
