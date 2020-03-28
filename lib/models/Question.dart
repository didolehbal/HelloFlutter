class Question {
  String title;
  List<Answer> answers;
  Question({this.title,this.answers});
}

class Answer{
  String answer;
  bool isCorrect;
  Answer({this.answer,this.isCorrect});
  String toString(){
    return "answer : $answer isCorrect : $isCorrect";
  }
}