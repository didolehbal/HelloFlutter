import "package:flutter/material.dart";
import 'package:flutterapp2/widgets/layout.dart';
import "../models//Question.dart";

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currQst = 0;
  int score = 0;

  final quiz = [
    Question(title: 'Which one is the best Mobile dev framework ?', answers: [
      Answer(answer: "Flutter", isCorrect: false),
      Answer(answer: "React-Native", isCorrect: true),
      Answer(answer: "Ionic", isCorrect: false),
    ]),
    Question(title: 'which is the worst programming language ever?', answers: [
      Answer(answer: "Java", isCorrect: true),
      Answer(answer: "Java", isCorrect: true),
      Answer(answer: "Java", isCorrect: true),
      Answer(answer: "khochaybat", isCorrect: false),
    ]),
    Question(title: 'who is the best teacher ever?', answers: [
      Answer(answer: "Pr Youssfi !", isCorrect: true),
      Answer(answer: "Pr Daaif", isCorrect: true),
      Answer(answer: "Pr Naji", isCorrect: true),
      Answer(answer: "Pr Mestari", isCorrect: true),
      Answer(answer: "Pr Qbadou", isCorrect: true),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Layout(
        title: "Quiz",
        body: currQst == quiz.length
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                    Text('votre score $score'),
                    RaisedButton(
                      child: Text("Restart"),
                      onPressed: () {
                        quiz.shuffle();
                        setState(() {
                          currQst = 0;
                          score = 0;
                        });
                      },
                    )
                  ]))
            : Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'Question ${currQst + 1}/${quiz.length}',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent),
                    ),
                  ),
                  QuestionWidget(
                      qst: quiz[currQst],
                      onAnswer: (Answer answer) {
                        setState(() {
                          if (answer.isCorrect == true) ++score;
                          currQst++;
                        });
                      }),
                ],
              ));
  }
}

class QuestionWidget extends StatelessWidget {
  QuestionWidget({@required this.qst, this.onAnswer});

  final Question qst;
  final Function onAnswer;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          qst.title,
          style: TextStyle(fontSize: 21),
        ),
        ...qst.answers.map((ans) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.lightBlueAccent,
                onPressed: () {
                  onAnswer(ans);
                },
                child: Container(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        ans.answer,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      )),
                  padding: EdgeInsets.all(10),
                ),
              ),
            ))
      ],
    );
  }
}
