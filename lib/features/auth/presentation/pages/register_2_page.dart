import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/widgets/custom_text_field.dart';
import 'otp_page.dart';

class Register2Page extends StatefulWidget {
  const Register2Page({super.key});

  @override
  State<Register2Page> createState() => _Register2PageState();
}

class _Register2PageState extends State<Register2Page> {
  final _phoneController = TextEditingController();
  final _cnicController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _selectedCountryCode = '+92';

  @override
  void dispose() {
    _phoneController.dispose();
    _cnicController.dispose();
    _dateOfBirthController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    try {
      setState(() {
        _isLoading = true;
      });
      
      // Navigate to OTP page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OtpPage(),
        ),
      );
      
      setState(() {
        _isLoading = false;
      });
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

  Future<void> _selectDateOfBirth() async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.primary,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: AppColors.textPrimary,
              ),
            ),
            child: child!,
          );
        },
      );
      
      if (picked != null) {
        setState(() {
          _dateOfBirthController.text = 
              '${picked.day.toString().padLeft(2, '0')} - ${picked.month.toString().padLeft(2, '0')} - ${picked.year}';
        });
      }
    } catch (e) {
      debugPrint('Error selecting date: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.cyan, AppColors.white,],
            stops: [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Gradient Section with Title
                Container(
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Text(
                      'Registration',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
                
                // White Form Section
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Phone Field
                        _buildFieldLabel('Phone *'),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Country Code Selector
                            Container(
                              width: 80,
                              height: 56,
                              decoration: BoxDecoration(
                                color: AppColors.pureWhite,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.border, width: 1),
                              ),
                              child: Center(
                                child: Text(
                                  _selectedCountryCode,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Phone Number Input
                            Expanded(
                              child: CustomTextField(
                                hintText: '03',
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                filled: false,
                                borderColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // CNIC Field
                        _buildFieldLabel('CNIC *'),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: '#####-#######-#',
                          controller: _cnicController,
                          keyboardType: TextInputType.text,
                          filled: false,
                          borderColor: Colors.black,
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Date of Birth Field
                        _buildFieldLabel('Data of birth *'),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'mm - day -year',
                          controller: _dateOfBirthController,
                          keyboardType: TextInputType.text,
                          onTap: _selectDateOfBirth,
                          filled: false,
                          borderColor: Colors.black,
                          suffixIcon: const Icon(
                            Icons.calendar_today,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Password Field
                        _buildFieldLabel('Password'),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.help_outline,
                              color: AppColors.textSecondary,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '≥8 chars, 1 letter, 1 number',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Enter your password',
                          controller: _passwordController,
                          isPassword: true,
                          filled: false,
                          borderColor: Colors.black,
                        ),
                        
                        const SizedBox(height: 40),
                        
                        // Submit Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : Text(
                                    'Submit',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.pureWhite,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          if (label.contains('*'))
            TextSpan(
              text: ' *',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.error,
              ),
            ),
        ],
      ),
    );
  }

}
