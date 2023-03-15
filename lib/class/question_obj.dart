class QuestionList {
  List<Question> question;

  QuestionList({required this.question});
}


class Question {
  String question,answer;
  int timer;

  Question({required this.question,required this.answer, required this.timer});

  factory Question.fromJson(Map<String, dynamic> parsedJson){
    return Question(
        question: parsedJson['question'],
        answer : parsedJson['answer'],
        timer : parsedJson ['answer']
    );
  }

  // Map toJson()=>{
  //   'question':question,
  //   'answer':answer,
  //   'timer':timer,
  // };
  //
  // @override
  // String toString() {
  //   return '{question: $question, answer: $answer, time:$timer}';
  // }
}

