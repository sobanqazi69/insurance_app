import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/widgets/auth_background.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/social_login_button.dart';
import '../../bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        
        // TODO: Implement sign up logic
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign up functionality coming soon!'),
            backgroundColor: AppColors.info,
          ),
        );
        
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.unknownError),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

 

  String? _validateFullName(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Full name is required';
      }
      
      if (value.trim().length < 2) {
        return 'Full name must be at least 2 characters';
      }
      
      return null;
    } catch (e) {
      return AppStrings.unknownError;
    }
  }

  String? _validateMobile(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return 'Mobile number is required';
      }
      
      final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
      if (!phoneRegex.hasMatch(value)) {
        return 'Please enter a valid mobile number';
      }
      
      return null;
    } catch (e) {
      return AppStrings.unknownError;
    }
  }

  String? _validateEmail(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return AppStrings.emailRequired;
      }
      
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return AppStrings.emailInvalid;
      }
      
      return null;
    } catch (e) {
      return AppStrings.unknownError;
    }
  }

  String? _validatePassword(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return AppStrings.passwordRequired;
      }
      
      if (value.length < 8) {
        return AppStrings.passwordMinLength;
      }
      
      return null;
    } catch (e) {
      return AppStrings.unknownError;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  
                  // Header Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.signUp,
                        style:  GoogleFonts.poppins(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppStrings.welcomeToSignUp,
                        style:  GoogleFonts.poppins(
                          fontSize: 16,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Form Fields
                  CustomTextField(
                    hintText: AppStrings.fullName,
                    controller: _fullNameController,
                    keyboardType: TextInputType.name,
                    validator: _validateFullName,
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  CustomTextField(
                    hintText: AppStrings.mobileNumber,
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    validator: _validateMobile,
                    prefixIcon: const Icon(
                      Icons.phone_outlined,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  CustomTextField(
                    hintText: AppStrings.enterEmail,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  CustomTextField(
                    hintText: AppStrings.enterPassword,
                    controller: _passwordController,
                    isPassword: true,
                    validator: _validatePassword,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Sign Up Button
                  CustomButton(
                    text: AppStrings.signUp,
                    onPressed: _handleSignUp,
                    isLoading: _isLoading,
                    isFullWidth: true,
                    backgroundColor: AppColors.primary,
                    height: 56,
                    borderRadius: 16,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Divider
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: AppColors.border,
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          AppStrings.orSignUpWith,
                          style:  GoogleFonts.poppins(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: AppColors.border,
                          thickness: 1,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Social Sign Up Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SocialLoginButton(
                        iconPath: 'assets/icons/facebook.svg',
                        label: 'Facebook',
                        onPressed: (){  },
                        backgroundColor: AppColors.pureWhite,
                      ),
                      SocialLoginButton(
                        iconPath: 'assets/icons/google.svg',
                        label: 'Google',
                        onPressed: (){},
                        backgroundColor: AppColors.pureWhite,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Login Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.alreadyHaveAccount,
                          style:  GoogleFonts.poppins(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigate to login page
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            AppStrings.loginNow,
                              style:  GoogleFonts.poppins(
                              color: AppColors.cyan,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
