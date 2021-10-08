import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/addquestion.dart';
import 'package:quizmaker/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String quizImageUrl, quizTitle, quizDescription;
  String quizId;
  bool _isLoading = false;
  DatabaseService databaseService = new DatabaseService();
  createOnlineQuiz() {
    if (_formKey.currentState.validate()) {
      quizId = randomAlphaNumeric(16);
      setState(() {
        _isLoading = true;
      });
      Map<String, String> quizData = {
        "quizId": quizId,
        "quiz Url": quizImageUrl,
        "quiz title": quizTitle,
        "quiz description": quizDescription
      };
      databaseService.addQuiz(quizData, quizId).then((val) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddQuestion(quizId)));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: appbar(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty
                            ? "enter correct Url for background image"
                            : null;
                      },
                      onChanged: (val) {
                        quizImageUrl = val;
                      },
                      decoration: InputDecoration(
                          hintText: "Quiz image Url (optional)"),
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "enter Quiz title " : null;
                      },
                      onChanged: (val) {
                        quizTitle = val;
                      },
                      decoration: InputDecoration(hintText: "Quiz Title"),
                    ),
                    SizedBox(height: 6),
                    TextFormField(
                      validator: (val) {
                        return val.isEmpty ? "enter quiz description " : null;
                      },
                      onChanged: (val) {
                        quizDescription = val;
                      },
                      decoration: InputDecoration(hintText: "Quiz Description"),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        createOnlineQuiz();
                      },
                      child: blueBotton(context: context, label: "Create Quiz"),
                    ),
                    SizedBox(
                      height: 50.0,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
