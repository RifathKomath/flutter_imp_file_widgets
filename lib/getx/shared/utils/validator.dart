String? validateRequired(String labelText, String? value) {
  if (value == null || value.trim().isEmpty) {
    return "$labelText is required";
  }
  return null;
}