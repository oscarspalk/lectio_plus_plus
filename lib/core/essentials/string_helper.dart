extension StringHelper on String? {
  bool get isNotNullOrEmpty => this != null && (this?.isNotEmpty ?? false);
}
