import 'package:flutter/material.dart';
import 'package:quizmaker/widgets/widgets.dart';

class Result extends StatefulWidget {
  final int totalQuestion, correct, incorrect, notAttempted;
  Result(
      {@required this.correct,
      @required this.incorrect,
      @required this.notAttempted,
      @required this.totalQuestion});

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),
        title: appbar(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Text(
              "Result",
              style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.cyan[500]),
            ),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Questions: ",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.totalQuestion}",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "NotAttempted: ",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.notAttempted}",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Correct: ",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.correct}",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Incorrect: ",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${widget.incorrect}",
                  style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
            SizedBox(
              height: 250.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: blueBotton(
                    context: context,
                    label: "Go to Home",
                    bottonWidth: MediaQuery.of(context).size.width / 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
