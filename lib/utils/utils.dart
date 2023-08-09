extension StringCheck on String? {
  bool get isNotEmptyValidator {
    if (this == null || this!.isEmpty) return false;
    return true;
  }

  bool get isValidUsername {
    if (this!.isEmpty) return false;
    //final nameRegExp = RegExp(r"^[A-Za-z][A-Za-z0-9_]{5,29}");
    //return nameRegExp.hasMatch(this!);
    return true;
  }

  bool get isValidPassword {
    if (this!.isEmpty) return false;
    // final passwordRegExp = RegExp( r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
    //return passwordRegExp.hasMatch(this!);
    return true;
  }

  bool get isValidName {
    if (this == null || this!.isEmpty) return false;
    final nameRegExp = RegExp(r"^[A-Za-z][A-Za-z0-9]{3,14}$");
    return nameRegExp.hasMatch(this!);
    //return true;
  }

  bool get isUpdateName {
    if (this == null || this!.isEmpty) return false;
    final nameRegExp = RegExp(r"^[A-Za-z][A-Za-z0-9]{3,14}$");
    return nameRegExp.hasMatch(this!);
  }
}
