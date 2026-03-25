class Validators {
  // ---------------- REGEX ----------------
  static final RegExp usernameRegex = RegExp(r'^[a-z0-9_]+$');
  static final RegExp phoneRegex = RegExp(r'^\+[1-9]\d{7,14}$');
  static final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp urlRegex = RegExp(r'^https?:\/\/.+');

  // ---------------- USERNAME ----------------
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < 3 || value.length > 20) {
      return 'Username must be 3–20 characters';
    }

    if (!usernameRegex.hasMatch(value)) {
      return 'Only lowercase letters, numbers, and _ allowed';
    }

    return null;
  }

  // ---------------- PHONE ----------------
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // optional
    }

    if (!phoneRegex.hasMatch(value)) {
      return 'Enter phone number with country code (e.g. +91XXXXXXXXXX)';
    }

    return null;
  }

  // ---------------- EMAIL ----------------
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  // ---------------- FULL NAME ----------------
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }

    if (value.trim().length < 2) {
      return 'Full name is too short';
    }

    return null;
  }

  // ---------------- BIO ----------------
  static String? validateBio(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Bio is required';
    }

    if (value.length > 160) {
      return 'Bio cannot exceed 160 characters';
    }

    return null;
  }

  // ---------------- URL (Social Links) ----------------
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // optional
    }

    if (!urlRegex.hasMatch(value)) {
      return 'Enter a valid URL (must start with http or https)';
    }

    return null;
  }
}
