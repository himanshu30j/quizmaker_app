import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/models/question_model.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/result.dart';
import 'package:quizmaker/widgets/play_quiz_widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz(this.quizId);
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correctAns = 0;
int _incorrectAns = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot questionSnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];
    questionModel.correctAns = questionSnapshot.data["option1"];
    questionModel.isAnswered = false;

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"]
    ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    return questionModel;
  }

  int totalTime = 0;
  String timeToDisplay = "";
  bool isSubmit = false;

  timerToStart() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        if (totalTime <= 1 || isSubmit) {
          isSubmit = true;

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Result(
                      correct: _correctAns,
                      incorrect: _incorrectAns,
                      notAttempted: _notAttempted,
                      totalQuestion: total)));
        } else if (totalTime < 60) {
          timeToDisplay = totalTime.toString();
          totalTime--;
        } else if (totalTime >= 60 && totalTime < 3600) {
          int min = totalTime ~/ 60;
          int sec = totalTime - min * 60;
          timeToDisplay = min.toString() + ":" + sec.toString();
          totalTime--;
        } else {
          int hour = totalTime ~/ 3600;
          int min = (totalTime - hour * 3600) ~/ 60;
          int sec = totalTime - (hour * 3600 + min * 60);
          timeToDisplay =
              hour.toString() + ":" + min.toString() + ":" + sec.toString();
          totalTime--;
        }
      });
    });
  }

  @override
  void initState() {
    databaseService.getQuestionData(widget.quizId).then((val) {
      questionSnapshot = val;

      setState(() {
        total = questionSnapshot.documents.length;
        totalTime = questionSnapshot.documents.length * 60;

        _correctAns = 0;
        _incorrectAns = 0;
        _notAttempted = total;
      });
    });
    // timerToStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.dark,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: Row(
                children: [
                  Text(
                    "Quiz",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Maker",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            // Text(
            //   "$timeToDisplay",
            //   style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 20.0,
            //       color: Colors.black),
            // )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isSubmit = true;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Result(
                      correct: _correctAns,
                      incorrect: _incorrectAns,
                      notAttempted: _notAttempted,
                      totalQuestion: total)));
        },
        child: Icon(Icons.check),
      ),
      body: Container(
        child: questionSnapshot == null
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                itemCount: questionSnapshot.documents.length,
                itemBuilder: (context, index) {
                  return QuizPlayTile(
                    questionModel: getQuestionModelFromDataSnapshot(
                      questionSnapshot.documents[index],
                    ),
                    index: index,
                  );
                }),
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final index;

  QuizPlayTile({@required this.questionModel, @required this.index});
  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String selectedOption = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(
              "Q${widget.index + 1}.  ${widget.questionModel.question}",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.isAnswered) {
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctAns) {
                  selectedOption = widget.questionModel.option1;
                  widget.questionModel.isAnswered = true;
                  _correctAns = _correctAns + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else {
                  selectedOption = widget.questionModel.option1;
                  widget.questionModel.isAnswered = true;
                  _incorrectAns = _incorrectAns + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                optionNo: "A",
                correctAns: widget.questionModel.correctAns,
                selectedOption: selectedOption,
                optionContent: widget.questionModel.option1),
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.isAnswered) {
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctAns) {
                  selectedOption = widget.questionModel.option2;
                  widget.questionModel.isAnswered = true;
                  _correctAns = _correctAns + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else {
                  selectedOption = widget.questionModel.option2;
                  widget.questionModel.isAnswered = true;
                  _incorrectAns = _incorrectAns + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                optionNo: "B",
                correctAns: widget.questionModel.correctAns,
                selectedOption: selectedOption,
                optionContent: widget.questionModel.option2),
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.isAnswered) {
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctAns) {
                  selectedOption = widget.questionModel.option3;
                  widget.questionModel.isAnswered = true;
                  _correctAns = _correctAns + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else {
                  selectedOption = widget.questionModel.option3;
                  widget.questionModel.isAnswered = true;
                  _incorrectAns = _incorrectAns + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                optionNo: "C",
                correctAns: widget.questionModel.correctAns,
                selectedOption: selectedOption,
                optionContent: widget.questionModel.option3),
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.isAnswered) {
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctAns) {
                  selectedOption = widget.questionModel.option4;
                  widget.questionModel.isAnswered = true;
                  _correctAns = _correctAns + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else {
                  selectedOption = widget.questionModel.option4;
                  widget.questionModel.isAnswered = true;
                  _incorrectAns = _incorrectAns + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                optionNo: "D",
                correctAns: widget.questionModel.correctAns,
                selectedOption: selectedOption,
                optionContent: widget.questionModel.option4),
          ),
        ],
      ),
    );
  }
}
