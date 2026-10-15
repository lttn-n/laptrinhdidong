class Vocabulary {
  String word;
  String meaning;
  Vocabulary({required this.word, required this.meaning});
  String toFileString() => '$word|$meaning';
  static Vocabulary fromString(String line) {
    final parts = line.split('|');
    return Vocabulary(word: parts.first, meaning: parts.skip(1).join('|'));
  }
}
