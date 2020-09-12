String validatePassword(String value) {
  if (value == null || value.length < 8) {
    return "Password must be at-least 8 chars long.";
  }

  if (!RegExp(r'([a-z])').hasMatch(value)) {
    return "Password must have one lowercase char.";
  }
  if (!RegExp(r'([0-9])').hasMatch(value)) {
    return "Password must have one number.";
  }
  return null;
}

String validatePhone(String value) {
  try {
    int.tryParse(value, radix: 10);
    if (value.length < 10) {
      return "Invalid phone number";
    }
    return null;
  } catch (e) {
    return "Invalid phone number";
  }
}

String validateName(String value) {
  if (value.isEmpty) {
    return "Invalid name";
  }
  return null;
}

String validateOtp(String value) {
  try {
    int.tryParse(value, radix: 10);
    if (value.length < 4) {
      return "Invalid OTP";
    }
    return null;
  } catch (e) {
    return "Invalid OTP";
  }
}
