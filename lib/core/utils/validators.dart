
class Validators {
  // validate name
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Full Name is required";
    }
    if (value.trim().length < 3) {
      return "Name must be at least 3 characters";
    }
    return null;
  }

  // validate email
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return "Email  is required";
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return "Enter valid Email";
    return null;
  }

  // validate Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < 6) return "Password must be at least 6 characters";
    return null;
  }
  // Re-Password
  static String? validateRePassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) return "Re-Enter your Password ";
    if (value != originalPassword) return "Passwords don\'t match";
    return null;
  }

  // validate phone
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return "Mobile Number is required";
    final phoneRegex = RegExp(r'^[0-9]{10,15}$');
    if (!phoneRegex.hasMatch(value)) return "Enter valid Mobile Number";
    return null;
  }

}
