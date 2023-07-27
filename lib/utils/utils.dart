

extension StringCheck on String? {
  bool get isEmailValid {
    if (this == null || this!.isEmpty) return false;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this!);
    return emailValid;
  }

  bool get isPasswordValid {
    if (this == null || this!.isEmpty||this!.length<8) return false;
    return true;
  }
}
