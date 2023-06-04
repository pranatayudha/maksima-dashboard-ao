class ThousandsSeparator {
  static int remove(String text) {
    final removedThousandsSeparator = text.split('.').join();

    return int.parse(removedThousandsSeparator);
  }
}
