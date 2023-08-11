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
    final nameRegExp = RegExp(r"^[A-Za-z][A-Za-z0-9_ ]{2,30}$");
    return nameRegExp.hasMatch(this!);
    //return true;
  }

  bool get isUpdateName {
    if (this == null || this!.isEmpty) return false;
    final nameRegExp = RegExp(r"^[A-Za-z][A-Za-z0-9]{3,14}$");
    return nameRegExp.hasMatch(this!);
  }

  bool get isValidTableCap {
    if (this == null || this!.isEmpty) return false;
    final tablecapRegExp = RegExp(r"\b([1-9]|1[0-6])\b$");
    return tablecapRegExp.hasMatch(this!);
  }

  bool get isValidDesc {
    if (this == null || this!.isEmpty) return false;
    final descRegExp = RegExp(r"^(.|\s)*[a-zA-Z]+(.|\s)*$");
    return descRegExp.hasMatch(this!);
  }

  bool get isValidPrice {
    if (this == null || this!.isEmpty) return false;
    final priceRegExp = RegExp(r"^\d{0,8}(\.\d{1,4})?$");
    return priceRegExp.hasMatch(this!);
  }

  bool get isValidProductName {
    if (this == null || this!.isEmpty) return false;
    final nameRegExp = RegExp(r"^[A-Za-z]([a-zA-Z0-9.-_,]|[- @.#&!])*$");
    return nameRegExp.hasMatch(this!);
    //return true;
  }
}
