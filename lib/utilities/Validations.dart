import 'package:truthordare/constants/Dictionary.dart';

class Validations {
  static String eventCodeValidation(String val) {
    if (val.isEmpty) return Dictionary.eventCodeValidation;
    return null;
  }

  static String locationValidation(String val) {
    if (val.isEmpty) return Dictionary.locationValidation;
    return null;
  }

  static String sampleCodeValidation(String val) {
    if (val.isEmpty) return Dictionary.labCodeValidation;
    return null;
  }

  static String usernameValidation(String val) {
    if (val.isEmpty) return Dictionary.usernameValidation;
    return null;
  }

  static String passwordValidation(String val) {
    if (val.isEmpty) return Dictionary.passwordValidation;
    return null;
  }

  static String registrationCodeValidation(String val) {
    if (val.isEmpty) return Dictionary.registrationCodeValidation;
    return null;
  }
}
