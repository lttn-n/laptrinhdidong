class Word {
  final String word;
  final String meaning;
  Word(this.word, this.meaning);

  String toFileString() =>
      '${word.replaceAll('|', ' ')}|${meaning.replaceAll('|', ' ')}';

  static Word fromString(String line) {
    final p = line.split('|');
    return Word(p[0], p.length > 1 ? p[1] : '');
  }
}