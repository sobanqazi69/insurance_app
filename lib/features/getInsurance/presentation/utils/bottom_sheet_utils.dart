import 'package:flutter/material.dart';
import '../widgets/insurance_compare_bottom_sheet.dart';

class BottomSheetUtils {
  static void showCompareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const InsuranceCompareBottomSheet(),
    );
  }
}
