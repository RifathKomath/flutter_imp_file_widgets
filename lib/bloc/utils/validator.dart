

String? validateRequired(String labelText, String? value) {
  if (value == null || value.trim().isEmpty) {
    return "$labelText is required";
  }
  return null;
}

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return "Email is required";
  }
  
  // Regular expression for email validation
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
  );
  
  if (!emailRegex.hasMatch(email)) {
    return "Email is not valid";
  }
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return "Mobile number is required";
  }

  // Remove any non-digit characters from the input value
  String numericValue = value.replaceAll(RegExp(r'\D'), '');

  if (numericValue.length != 10) {
    return "Mobile number must have exactly 10 digits";
  }

  // Check if the numericValue consists only of numeric digits (0-9)
  if (!numericValue.contains(RegExp(r'^[0-9]+$'))) {
    return "Mobile number can only contain numbers";
  }

  // Check if the numericValue is not a sequence of repeated digits (e.g., "000000")
  if (isAllDigitsSame(numericValue)) {
    return "Mobile number cannot consist of the same\n repeated digit";
  }

  return null; // Return null if the input is a valid 10-digit numeric mobile number
}

bool isAllDigitsSame(String value) {
  // Check if all characters in the value string are the same
  return value.runes.length > 1 && value.runes.toSet().length == 1;
}







