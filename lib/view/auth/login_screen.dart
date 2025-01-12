import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/app_colors.dart';
import 'package:todo_list_app/constants/app_style.dart';
import 'package:todo_list_app/view/auth/signup_screen.dart';
import 'package:todo_list_app/view/widgets_custom/custom_buttons.dart';
import 'package:todo_list_app/view/widgets_custom/custom_text_field.dart';
import 'package:todo_list_app/viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.accent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 20 : 40,
            vertical: isSmallScreen ? 20 : 40,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Login",
                  style: AppStyles.heading
                      .copyWith(fontSize: isSmallScreen ? 28 : 36),
                ),
                SizedBox(height: isSmallScreen ? 20 : 40),
                const Text(
                  "Welcome back! Please login to your account.",
                  style: AppStyles.body,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isSmallScreen ? 20 : 40),
                CustomTextField(
                  label: "Email",
                  icon: Icons.email,
                  controller: authViewModel.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: isSmallScreen ? 15 : 30),
                CustomTextField(
                  label: "Password",
                  icon: Icons.lock,
                  obscureText: true,
                  controller: authViewModel.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: isSmallScreen ? 20 : 40),
                authViewModel.isLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: "Login",
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await authViewModel.login(context);
                          }
                        },
                        backgroundColor: AppColors.primary,
                        textColor: AppColors.textPrimary,
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 50 : 80,
                          vertical: isSmallScreen ? 12 : 16,
                        ),
                      ),
                SizedBox(height: isSmallScreen ? 10 : 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(color: AppColors.accent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
