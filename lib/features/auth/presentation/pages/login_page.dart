import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insurance_app/features/auth/presentation/pages/register_page.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/widgets/auth_background.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/social_login_button.dart';
import '../../bloc/auth_bloc.dart'; 
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        
        context.read<AuthBloc>().add(
          LoginRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );
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



  

  String? _validateEmailOrPhone(String? value) {
    try {
      if (value == null || value.isEmpty) {
        return AppStrings.emailRequired;
      }
      
      // Check if it's an email
      if (value.contains('@')) {
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return AppStrings.emailInvalid;
        }
      } else {
        // Check if it's a phone number
        final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
        if (!phoneRegex.hasMatch(value)) {
          return AppStrings.phoneInvalid;
        }
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        try {
          if (state is AuthError) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          } else if (state is AuthAuthenticated) {
            setState(() {
              _isLoading = false;
            });
            // TODO: Navigate to home page
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login successful!'),
                backgroundColor: AppColors.success,
              ),
            );
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
      },
      child: Scaffold(
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
                    
                    // Title Section
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.login,
                          style:  GoogleFonts.poppins(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: AppColors.primary,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppStrings.welcomeBack,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Form Fields
                    CustomTextField(
                      hintText: AppStrings.emailOrPhone,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmailOrPhone,
                      
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    CustomTextField(
                      hintText: AppStrings.password,
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
                    
                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Navigate to forgot password page
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          AppStrings.forgotPassword,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Login Button
                    CustomButton(
                      text: AppStrings.login,
                      onPressed: _handleLogin,
                      isLoading: _isLoading,
                      isFullWidth: true,
                      backgroundColor: AppColors.primary,
                      height: 56,
                      borderRadius: 16,
                      textColor: AppColors.pureWhite,
                    ),
                    
                    const SizedBox(height: 40),
                    
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
                            AppStrings.orLoginWith,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
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
                    
                    const SizedBox(height: 40),
                    
                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SocialLoginButton(
                          iconPath: 'assets/icons/facebook.svg',
                          label: 'Facebook',
                          onPressed: (){},
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
                    
                    const SizedBox(height: 60),
                    
                    // Register Link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.dontHaveAccount,
                            style:  GoogleFonts.poppins(
                              color: AppColors.textSecondary,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 4),
                          TextButton(
                            onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              AppStrings.registerNow,
                              style:  GoogleFonts.poppins(
                                decoration: TextDecoration.underline,
                                color: AppColors.cyan,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
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
      ),
    );
  }
}
