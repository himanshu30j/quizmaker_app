import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4;
  DatabaseService databaseService = new DatabaseService();
  bool isLoading = false;
  uploadQuizData() {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      Map<String, String> questionData = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };
      databaseService.addQuestionData(questionData, widget.quizId).then((val) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black87),
        title: appbar(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty ? "enter Question" : null;
                        },
                        onChanged: (val) {
                          question = val;
                        },
                        decoration: InputDecoration(hintText: "Question"),
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty
                              ? "enter option1 (correct option)"
                              : null;
                        },
                        onChanged: (val) {
                          option1 = val;
                        },
                        decoration: InputDecoration(
                            hintText: "option1 (correct option)"),
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty ? "enter option2" : null;
                        },
                        onChanged: (val) {
                          option2 = val;
                        },
                        decoration: InputDecoration(hintText: "option2"),
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty ? "enter option3" : null;
                        },
                        onChanged: (val) {
                          option3 = val;
                        },
                        decoration: InputDecoration(hintText: "option3"),
                      ),
                      SizedBox(height: 6),
                      TextFormField(
                        validator: (val) {
                          return val.isEmpty ? "enter option4" : null;
                        },
                        onChanged: (val) {
                          option4 = val;
                        },
                        decoration: InputDecoration(hintText: "option4"),
                      ),
                      SizedBox(
                        height: 250.0,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  uploadQuizData();
                                  Navigator.pop(context);
                                },
                                child: blueBotton(
                                    context: context,
                                    label: "Submit",
                                    bottonWidth:
                                        MediaQuery.of(context).size.width / 2 -
                                            36)),
                            GestureDetector(
                                onTap: () {
                                  uploadQuizData();
                                },
                                child: blueBotton(
                                    context: context,
                                    label: "Add Question",
                                    bottonWidth:
                                        MediaQuery.of(context).size.width / 2 -
                                            36)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
