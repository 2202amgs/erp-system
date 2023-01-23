import 'package:flutter/material.dart';
import 'package:frontend/presentation/auth/controllers/auth_controller.dart';
import 'package:frontend/app/core/constants/app_colors.dart';
import 'package:frontend/app/core/constants/app_sizes.dart';
import 'package:frontend/presentation/auth/views/widgets/input_login_field.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(AppSize.s2),
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontSize: AppSize.s12,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: AppSize.s5),
              InputLoginField(
                controller: authController.emailController,
                label: 'البريد الإلكترونى',
              ),
              SizedBox(height: AppSize.s2),
              InputLoginField(
                controller: authController.passwordController,
                label: 'كلمة السر',
                isPassword: true,
              ),
              SizedBox(height: AppSize.s2),
              ElevatedButton(
                onPressed: () {
                  authController.login(
                    email: authController.emailController.text,
                    password: authController.passwordController.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.maxFinite, 50)),
                child: Text(
                  'تسجيل الدخول',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
