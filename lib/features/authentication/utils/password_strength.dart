enum PasswordStrength {
  weak,
  medium,
  strong,
}

PasswordStrength checkPasswordStrength(String password) {
  if (password.length < 8) {
    return PasswordStrength.weak;
  }
  
  bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
  bool hasLowercase = password.contains(RegExp(r'[a-z]'));
  bool hasDigits = password.contains(RegExp(r'[0-9]'));
  bool hasSpecialChars = password.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  int strength = 0;
  if (hasUppercase) strength++;
  if (hasLowercase) strength++;
  if (hasDigits) strength++;
  if (hasSpecialChars) strength++;

  if (strength >= 3) {
    return PasswordStrength.strong;
  } else if (strength >= 2) {
    return PasswordStrength.medium;
  } else {
    return PasswordStrength.weak;
  }
}
