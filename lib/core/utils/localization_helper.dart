import 'package:flutter/material.dart';
import '../constants/strings.dart';

class LocalizationHelper {
  static String getString(String key) {
    try {
      switch (key) {
        case 'login':
          return AppStrings.login;
        case 'welcomeBack':
          return AppStrings.welcomeBack;
        case 'emailOrPhone':
          return AppStrings.emailOrPhone;
        case 'password':
          return AppStrings.password;
        case 'forgotPassword':
          return AppStrings.forgotPassword;
        case 'orLoginWith':
          return AppStrings.orLoginWith;
        case 'dontHaveAccount':
          return AppStrings.dontHaveAccount;
        case 'registerNow':
          return AppStrings.registerNow;
        case 'emailRequired':
          return AppStrings.emailRequired;
        case 'emailInvalid':
          return AppStrings.emailInvalid;
        case 'phoneRequired':
          return AppStrings.phoneRequired;
        case 'phoneInvalid':
          return AppStrings.phoneInvalid;
        case 'passwordRequired':
          return AppStrings.passwordRequired;
        case 'passwordMinLength':
          return AppStrings.passwordMinLength;
        case 'loginFailed':
          return AppStrings.loginFailed;
        case 'networkError':
          return AppStrings.networkError;
        case 'unknownError':
          return AppStrings.unknownError;
        default:
          return key;
      }
    } catch (e) {
      return key;
    }
  }

  // Method to get localized text with parameters
  static String getStringWithParams(String key, Map<String, String> params) {
    try {
      String text = getString(key);
      
      params.forEach((paramKey, paramValue) {
        text = text.replaceAll('{$paramKey}', paramValue);
      });
      
      return text;
    } catch (e) {
      return key;
    }
  }

  // Method to get localized text based on current locale
  static String getLocalizedString(BuildContext context, String key) {
    try {
      final locale = Localizations.localeOf(context);
      // For now, we'll use the default strings
      // In the future, you can implement different language files here
      return getString(key);
    } catch (e) {
      return key;
    }
  }
}
