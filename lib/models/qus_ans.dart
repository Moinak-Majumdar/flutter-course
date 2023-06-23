class QuestionAnswers {
  const QuestionAnswers({required this.question, required this.options});

  final String question;
  final List<String> options;

  List<String> shuffledOptions() {
    final shuffled = List.of(options);
    shuffled.shuffle();
    return shuffled;
  }
}
