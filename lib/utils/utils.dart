

extension StringCheck on String? {
  bool get isUserIdValid {
    if (this == null || this!.isEmpty) return false;
    return true;
  }

  bool get isPasswordValid {
    if (this == null || this!.isEmpty||this!.length<0) return false;
    return true;
  }
}
