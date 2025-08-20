import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryDark = Color(0xFF059669);
  
  // Accent Colors
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentLight = Color(0xFFFBBF24);
  static const Color accentDark = Color(0xFFD97706);
  
  // Success Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF047857);
  
  // Warning Colors
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFFD97706);
  
  // Error Colors
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFDC2626);
  
  // Info Colors
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);
  static const Color infoDark = Color(0xFF2563EB);
  
  // Neutral Colors (Light Theme)
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);
  
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textDisabled = Color(0xFFCBD5E1);
  
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color divider = Color(0xFFE2E8F0);
  
  static const Color shadow = Color(0x1A000000);
  static const Color overlay = Color(0x80000000);
  
  // Neutral Colors (Dark Theme)
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkSurfaceVariant = Color(0xFF334155);
  
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkTextTertiary = Color(0xFF94A3B8);
  static const Color darkTextDisabled = Color(0xFF64748B);
  
  static const Color darkBorder = Color(0xFF334155);
  static const Color darkBorderLight = Color(0xFF475569);
  static const Color darkDivider = Color(0xFF334155);
  
  static const Color darkShadow = Color(0x40000000);
  static const Color darkOverlay = Color(0xCC000000);
  
  // Insurance Specific Colors
  static const Color autoInsurance = Color(0xFF3B82F6);
  static const Color homeInsurance = Color(0xFF10B981);
  static const Color healthInsurance = Color(0xFFEF4444);
  static const Color lifeInsurance = Color(0xFF8B5CF6);
  static const Color travelInsurance = Color(0xFFF59E0B);
  static const Color businessInsurance = Color(0xFF06B6D4);
  
  // Status Colors
  static const Color pending = Color(0xFFF59E0B);
  static const Color approved = Color(0xFF10B981);
  static const Color rejected = Color(0xFFEF4444);
  static const Color processing = Color(0xFF3B82F6);
  static const Color completed = Color(0xFF10B981);
  static const Color cancelled = Color(0xFF6B7280);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient successGradient = LinearGradient(
    colors: [success, successLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient errorGradient = LinearGradient(
    colors: [error, errorLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Utility Methods
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return pending;
      case 'approved':
        return approved;
      case 'rejected':
        return rejected;
      case 'processing':
        return processing;
      case 'completed':
        return completed;
      case 'cancelled':
        return cancelled;
      default:
        return textSecondary;
    }
  }
  
  static Color getInsuranceTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'auto':
        return autoInsurance;
      case 'home':
        return homeInsurance;
      case 'health':
        return healthInsurance;
      case 'life':
        return lifeInsurance;
      case 'travel':
        return travelInsurance;
      case 'business':
        return businessInsurance;
      default:
        return primary;
    }
  }
}
