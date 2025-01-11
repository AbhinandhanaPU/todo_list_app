import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/app_colors.dart';
import 'package:todo_list_app/constants/app_style.dart';
import 'package:todo_list_app/view/auth/login_screen.dart';
import 'package:todo_list_app/view/auth/signup_screen.dart';
import 'package:todo_list_app/view/widgets_custom/custom_buttons.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: screenHeight * 0.1,
            horizontal: screenWidth * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("WELCOME", style: AppStyles.heading),
              SizedBox(height: screenHeight * 0.03),
              const Text(
                "Login into your existing account or create a new one",
                textAlign: TextAlign.center,
                style: AppStyles.body,
              ),
              SizedBox(height: screenHeight * 0.2),
              CustomButton(
                text: "Login",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                },
                backgroundColor: AppColors.primary,
                textColor: AppColors.textPrimary,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.3,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              CustomButton(
                text: "Sign Up",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                },
                backgroundColor: AppColors.accent,
                textColor: AppColors.primary,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
