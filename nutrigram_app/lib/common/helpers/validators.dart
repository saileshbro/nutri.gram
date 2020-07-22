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
