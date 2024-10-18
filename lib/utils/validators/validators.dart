class Validators {
  static validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is Required";
    }
    final emailRegEx = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!emailRegEx.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "Password must be at least 6 character long.";
    }

    /// for upper case
    if (value.contains(RegExp(r"[A-Z]"))) {
      return "Password must contain at least one upper case letter";
    }

    /// chect number
    if (value.contains(RegExp(r"[0-9]"))) {
      return "Password must contain at least one number";
    }
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least one special character";
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone Number is required";
    }

    /// regular expression for phone number validation (assuming  a 10-digit code PK number  )
    final phoneRegEx = RegExp(r'^\d{10}$');
    if (!phoneRegEx.hasMatch(value)) {
      return "Invalid phone number format (10 digit required) ";
    }
    return null;
  }
}
