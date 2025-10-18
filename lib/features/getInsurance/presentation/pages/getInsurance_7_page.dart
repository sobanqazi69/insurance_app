import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/colors.dart';
import '../../../../shared/services/navigation_service.dart';
import '../widgets/insurance_app_bar.dart';
import '../widgets/insurance_dashed_input_field.dart';

class GetInsurance7Page extends StatefulWidget {
  const GetInsurance7Page({super.key});

  @override
  State<GetInsurance7Page> createState() => _GetInsurance7PageState();
}

class _GetInsurance7PageState extends State<GetInsurance7Page> {
  String? selectedInspectionType;
  String? selectedDevice;

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      );
    } catch (e) {
      debugPrint('Error building GetInsurance7Page: $e');
      return _buildErrorWidget(context);
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return const InsuranceAppBar(title: 'Inspection Now');
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            _buildInspectionForm(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            _buildSubmitButton(context),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildInspectionForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownField(
            context,
            label: 'Choose *',
            value: selectedInspectionType,
            items: ['Self Inspection'],
            onChanged: (value) {
              setState(() {
                selectedInspectionType = value;
              });
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildDropdownField(
            context,
            label: 'Select *',
            value: selectedDevice,
            items: ['Mobile'],
            onChanged: (value) {
              setState(() {
                selectedDevice = value;
              });
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildPhotosSection(context),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    BuildContext context, {
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.016,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Container(
          height: MediaQuery.of(context).size.height * 0.055,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: AppColors.primary, width: 1.0),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03,
              ),
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.016,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotosSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Photos for inspection',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.02,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        InsuranceDashedInputField(
          label: '',
          placeholder: 'Upload Mobile IMEI screen shot and front/back power button',
          onTap: () => _handlePhotoUpload(context),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
        onPressed: () => _handleSubmit(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          'Submit',
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.height * 0.018,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  void _handlePhotoUpload(BuildContext context) {
    try {
      debugPrint('Photo upload tapped');
      // TODO: Implement photo upload functionality
    } catch (e) {
      debugPrint('Error handling photo upload: $e');
    }
  }

  void _handleSubmit(BuildContext context) {
    try {
      debugPrint('Submit tapped');
      // TODO: Implement submit functionality
    } catch (e) {
      debugPrint('Error handling submit: $e');
    }
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => NavigationService.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
        ),
        title: Text(
          'Inspection Now',
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Error loading form',
          style: GoogleFonts.poppins(
            color: AppColors.primary,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
